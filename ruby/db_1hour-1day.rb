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
conf = "/home/sugiyama/iotex-server/conf/db_info.yml"

# データベースのテーブル名
mytable_from = "monitoring_1hour"
mytable_to   = {
  "min"     => "monitoring_1day_min",
  "max"     => "monitoring_1day_max",
  "avg"     => "monitoring_1day_avg",
  "stddev"  => "monitoring_1day_stddev"
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
time_from = DateTime.new( 2017, 1, 1, 0, 0, 0, "JST")

# テーブルに既に値が入っている場合は平均開始時刻 time_from の値を更新する. 
sql = "SELECT time FROM #{mytable_to['min']} ORDER BY time DESC LIMIT 1"
client.query(sql).each do |item|
  if item["time"].present?
    time_from = Time.parse( item["time"].to_s ) + 12.hour
  end
end

# 平均を終了する時間
time_end = DateTime.now

###
### カラム名の取得
###
columns1 = Array.new 
columns2 = Hash.new
columns2["avg"] = Array.new
columns2["min"] = Array.new
columns2["max"] = Array.new
columns2["stddev"] = Array.new 
sql = "show columns from #{mytable_from}"
client.query(sql).each do |item|
  if item["Field"] != "hostname" && item["Field"] != "time"

    columns1.push( item["Field"] )

    # 平均操作. 24 点以上のデータ数があれば平均をとり，なければ null にする.
    columns2["avg"].push( "(case when count(#{mytable_from}.#{item["Field"]}) >= 24 then AVG(#{mytable_from}.#{item["Field"]}) else null end) as #{item["Field"]}")
    
    # 最小操作. 24 点以上のデータ数があれば平均をとり，なければ null にする.
    columns2["min"].push( "(case when count(#{mytable_from}.#{item["Field"]}) >= 24 then MIN(#{mytable_from}.#{item["Field"]}) else null end) as #{item["Field"]}")
    
    # 最大操作. 24 点以上のデータ数があれば平均をとり，なければ null にする.
    columns2["max"].push( "(case when count(#{mytable_from}.#{item["Field"]}) >= 24 then MAX(#{mytable_from}.#{item["Field"]}) else null end) as #{item["Field"]}")
    
    # 標準偏差操作. 24 点以上のデータ数があれば平均をとり，なければ null にする.
    columns2["stddev"].push( "(case when count(#{mytable_from}.#{item["Field"]}) >= 24 then STDDEV(#{mytable_from}.#{item["Field"]}) else null end) as #{item["Field"]}")
  end
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

  ["min","max","avg","stddev"].each do |var|
    
    sql = "INSERT INTO #{mytable_to["#{var}"]} (hostname,time,#{columns1.join(',')})
           SELECT hostname, '#{time0.strftime('%Y-%m-%d')} 12:00:00', #{columns2["#{var}"].join(',')}
           FROM #{mytable_from} 
           WHERE time > '#{time0.strftime('%Y-%m-%d %H:%M:%S')}' AND time <= '#{time1.strftime('%Y-%m-%d %H:%M:%S')}' 
           GROUP BY hostname ORDER BY time "
    p sql

    # SQL 実行. 
    client.query(sql)
  end

  time0 = time1
  time1 = time1 + 1.days
end

