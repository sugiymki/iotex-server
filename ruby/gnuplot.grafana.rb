#!/usr/bin/env ruby
# coding: utf-8
#

require 'csv'
require 'date'
require 'fileutils'
require 'numo/gnuplot'

###
### 初期化
###

#ホスト名 (要編集)
myhost  = "sxxxx"  

# 出力ファイル (要編集)
output  = "/home/hogehoge/public_html/output2.png"

#CSV ファイル. grafana より export (要編集)
csvfile = "/home/hogehoge/public_html/monitoring_10min.csv"

# 配列初期化
time_list = []
data_list = []

###
### csv ファイルの読み込み
###
CSV.foreach( csvfile, {:encoding => "UTF-8", :col_sep => ";" }) do |row|

  #指定したホストのデータのみ利用
  next unless row[0].to_s == myhost

  # 時刻の取得 
  time_list.push( row[1] )

  # 欠損値か否かで分岐
  unless row[2] == "null"
    # 10 分平均値は 3 番目のカラム (添字番号 2) に入っている.
    data_list.push( row[2].to_f ) 
  else
#    data_list.push( "NaN" )
    data_list.push( 999 )
  end
end

# 作図
Numo.gnuplot do
  debug_on
  set title:    "Temperature measured by #{myhost}"
  set ylabel:   "temperature (C)"
  set xlabel:   "time"
  set xdata:    "time"
  set timefmt:  "%Y-%m-%dT%H:%M:%S+09:00"
  set format_x: "%m/%d %H:%M"
  set xtics:    "rotate by -60"
  set terminal: "png"
  set output:   "#{output}"
  #set :datafile, :missing, "NaN"    #欠損値
  set :datafile, :missing, "999"    #欠損値
  
  #plot time_list, data_list, using:'1:($2)', with:"points", lc_rgb:"red", lw:2, title:"temp"
  plot time_list, data_list, using:'1:($2)', with:"linespoints", lc_rgb:"red", lw:2, title:"temp"
end
