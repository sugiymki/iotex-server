#!/usr/bin/env ruby
# coding: utf-8
#
# 表題: データ解析スクリプト. 1 日平均値を作る
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
mytable_from = "monitoring_1hour"
mytable_to   = {
  "min"     => "monitoring_1day_min",
  "max"     => "monitoring_1day_max",
  "avg"     => "monitoring_1day_avg",
  "stddev"  => "monitorig_1day_stddev"
}

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

# 平均を開始する時間 (デフォルト値)
time_from = DateTime.new( 2019, 8, 1, 0, 0, 0, "JST")

# テーブルに既に値が入っている場合は平均開始時刻 time_from の値を更新する. 
sql = "SELECT time FROM #{mytable_to['min']} ORDER BY time DESC LIMIT 1"
client.query(sql).each do |item|
  if item["time"].present?
    time_from = Time.parse( item["time"].to_s )
  end
end

# 平均を終了する時間
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
### 1 日分 (0:00 ~ 23:00) のデータから最大・最小・平均・標準偏差を計算
###

# 時刻の初期化
time0 = time_from
time1 = time_from + 1.days

# ループを回しながら最大・最小・平均・標準偏差をとる. 
while ( time1 < time_end ) do
  p "#{time0} ... #{time1}"

  ####
  #### 最小値
  ####
  data = ""
  hosts.each do |myhost|
    sql = "SELECT count(time) as count, #{columns2.join(',').gsub('AVG','MIN')}
             FROM #{mytable_from} 
             WHERE time >= '#{time0}' AND time < '#{time1}' 
             AND hostname LIKE '#{myhost}' ORDER BY time"
    p sql
    
    # 変数初期化
    columns3 = Array.new
    
    # SQL の出力を用いて不快指数を計算し, 新たなテーブルに入れる. 
    client.query(sql).each do |item|
      p item
      
      # 各物理量の値を取得. 値がない場合は null にする. 
      columns1.each do |column|
      
        #初期化
        var = "null"
        
        # 24 時間分のデータが揃っているか確認
        p item["count"]
        if item["count"] == 24 && item["#{column}"]
          var = sprintf('%.2f', item["#{column}"])
        end
      
        # 保管
        columns3.push( var )
      end

      # ある時間に入力するデータをまとめる.
      data += "('#{myhost}','#{time0.strftime('%Y-%m-%d')}',#{columns3.join(',')}),"
    end
  end
  # 新たなテーブルへ入力
  sql = "INSERT INTO #{mytable_to["min"]} (hostname,time,#{columns1.join(',')}) VALUES #{data.chop}"
  p sql
  client.query(sql)

  ####
  #### 最大値
  ####

     #### ここに自分でスクリプトを書く ####


  ####
  #### 平均値
  ####

     #### ここに自分でスクリプトを書く ####

  ####
  #### 標準偏差
  ####

     #### ここに自分でスクリプトを書く ####

  
  time0 = time1
  time1 = time1 + 1.days
end

