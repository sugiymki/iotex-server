#!/usr/bin/env ruby
# coding: utf-8
#
# 表題: データ解析スクリプト. DB から 1 時間おきの値を抽出する.
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
mytable_from = "monitoring_10min"
mytable_to   = "monitoring_1hour"

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
sql = "SELECT time FROM #{mytable_to} ORDER BY time DESC LIMIT 1"
client.query(sql).each do |item|
  if item["time"].present?
    time_from = Time.parse( item["time"].to_s )
  end
end

###
### 毎正時の値を抽出
###
sql = "INSERT INTO #{mytable_to} 
       SELECT * FROM #{mytable_from} 
       WHERE TIME(time) LIKE '%00:00' AND time > '#{time_from.strftime('%Y-%m-%d %H:%M:%S')}' "
p sql
client.query(sql)

