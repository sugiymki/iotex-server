#!/usr/bin/env ruby
# coding: utf-8
#
# 表題: DB から取り出した 1 分毎のデータから 10 分平均データを作る.
#
# Author: SUGIYAMA Ko-ichiro
#

require 'yaml'
require 'mysql2'
require 'fileutils'
require 'active_support/time'

###
### 変数宣言
###

# データベースへの接続情報の置き場.
# ~/public_html 以下には置かないこと.
conf = "/home/hogehoge/iotex-server/conf/db_info.yml"

# データベースのテーブル名
mytable_from = "monitoring"
mytable_to   = "monitoring_10min"

# 設定ファイルの読み込み
mydb = YAML.load_file( conf )

# データベースへの接続
client = Mysql2::Client.new(
  :host     => "#{mydb["SERV"]}",
  :username => "#{mydb["USER"]}",
  :password => "#{mydb["PASS"]}",
  :database => "#{mydb["DBNM"]}"
)

###
### 時刻の設定
###

# 平均操作を開始する時間 (デフォルト値)
time_from = DateTime.new( 2019, 8, 1, 0, 0, 0, "JST")

# テーブルに既に値が入っている場合は平均操作を開始する時刻 time_from の値を更新する. 
sql = "SELECT time FROM #{mytable_to} ORDER BY time DESC LIMIT 1"
client.query(sql).each do |item|
  if item["time"].present?
    time_from = Time.parse( item["time"].to_s )
  end
end

# 平均操作を終了する時間. 現在時刻にセット. 
time_end = DateTime.now

###
### カラム名の取得
###
columns1 = Array.new 
columns2 = Array.new 
sql = "show columns from #{mytable_from}"
client.query(sql).each do |item|
  if item["Field"] != "hostname" && item["Field"] != "time"
    columns1.push( item["Field"] )
    columns2.push( "AVG(#{item["Field"]}) as #{item["Field"]}") #SQL 用に整形
  end
end

###
### ホスト名の取得
###
hosts = Array.new 
sql = "SELECT DISTINCT hostname FROM #{mytable_from}"
client.query(sql).each do |item|
  hosts.push( item["hostname"] )
end

###
### 前 10 分平均値の計算とテーブルへの代入
###

# 変数の初期化
time0 = time_from
time1 = time_from + 10.minutes 
data = ""

# ループを回しながら 10 分平均をとる. 
while ( time1 < time_end ) do
  p "#{time0} ... #{time1}"

  hosts.each do |myhost|
    
    # 平均値と, 10 分間に何回記録されているか, を調べる. 
    sql = "SELECT hostname, count(time) as count, #{columns2.join(',')}
           FROM #{mytable_from} 
           WHERE time > '#{time0}' AND time <= '#{time1}' 
           AND hostname LIKE '#{myhost}' ORDER BY time"

    # 変数初期化
    columns3 = Array.new
  
    # SQL 実行. 上記 SQL 分は戻り値が 1 行分であることを前提にしている
    result = client.query(sql)
    item = Hash.new
    if result
      result.each do |item0|
        item = item0
      end
    end

    # 各物理量の平均値を取得. 値がない場合は null にする. 
    columns1.each do |column|
      
      #初期化
      var = "null"
          
      # 10 分のうち, 5 点以上のデータがあるなら平均値を使う
      if item["count"] > 5 && item["#{column}"]
        var = sprintf('%.2f', item["#{column}"])
      end
      
      # 保管
      columns3.push( var )
    end

    # ある時間に入力するデータをまとめる.
    data += "('#{myhost}','#{time1.strftime('%Y-%m-%d %H:%M:%S')}',#{columns3.join(',')}),"

  end    
  
  # 時刻の更新
  time0 = time1
  time1 = time1 + 10.minutes
end

###
### データの挿入
### 平均値を新たなテーブルへ入力. 全時刻の分をまとめて入力する. 計算時間の節約のために.
###
if data != ""
  sql = "INSERT INTO #{mytable_to} (hostname,time,#{columns1.join(',')}) VALUES #{data.chop}"
  p sql
  client.query(sql)
end

exit
