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
conf = "/home/sugiyama/iotex-server/conf/db_info.yml"

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
time_from = DateTime.new( 2021, 1, 1, 0, 0, 0, "JST")

# テーブルに既に値が入っている場合は平均開始時刻 time_from の値を更新する. 
sql = "SELECT time FROM #{mytable_to} ORDER BY time DESC LIMIT 1"
client.query(sql).each do |item|
  if item["time"].present?
    time_from = Time.parse( item["time"].to_s )
  end
end

# 平均操作を終了する時間. 現在時刻にセット. 
#time_end = DateTime.new( ARGV[0].to_i, 3, 6, 0, 0, 0, "JST")
time_end = DateTime.now

###
### カラム名の取得
###
columns1 = Array.new 
columns2 = Array.new 
sql = "show columns from #{mytable_from}"
client.query(sql).each do |item|
  if item["Field"] != "hostname" && item["Field"] != "time"

    # 物理量のカラム名
    columns1.push( item["Field"] )

    # 平均操作. 3 点以上のデータ数があれば平均をとり，なければ null にする.
    columns2.push( "(case when count(#{mytable_from}.#{item["Field"]}) >= 3 then AVG(#{mytable_from}.#{item["Field"]}) else null end) as #{item["Field"]}") 
  end
end


# ホスト名. iot-01 ... iot-99 まで用意しておく.
# "GROUP BY monitoring_rooms_id.id ORDER BY time " とすると欠損値が作れない
hosts = Array.new
99.times do |i|
  hosts.push( "iot-#{sprintf('%02d', i+1)}" )
end

# 変数の初期化
time0 = time_from
time1 = time_from + 10.minutes 
data = ""

# ループを回しながら 10 分平均をとる. 
while ( time1 < time_end ) do
  p "#{time0} ... #{time1}"

  hosts.each do |host|
    # 平均値を計算して INSERT する.
    sql = "INSERT INTO #{mytable_to} (hostname,time,#{columns1.join(',')})
           SELECT '#{host}', '#{time1.strftime('%Y-%m-%d %H:%M:%S')}', #{columns2.join(',')}
            FROM #{mytable_from} 
            INNER JOIN monitoring_rooms_id ON #{mytable_from}.hostname LIKE monitoring_rooms_id.hostname
            WHERE time > '#{time0.strftime('%Y-%m-%d %H:%M:%S')}' 
              AND time <= '#{time1.strftime('%Y-%m-%d %H:%M:%S')}'  
              AND monitoring_rooms_id.id like '#{host}' 
            ORDER BY time "
    p sql
  
    # SQL 実行. 
    client.query(sql)
  end
  
  # 時刻の更新
  time0 = time1
  time1 = time1 + 10.minutes
end

