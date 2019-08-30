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
output  = "/home/hogehoge/public_html/output.png"

#CSV ファイル. 以下のコマンドで作成. 
# $ mysqldump -u hogehoge -p --tab=/tmp --fields-terminated-by=, iotex monitoring_10min
csvfile = "/tmp/monitoring_10min.txt"

# 配列初期化
time_list = []
data_list = []

###
### csv ファイルの読み込み
###
CSV.foreach( csvfile, {:encoding => "UTF-8", :col_sep => "," }) do |row|

  # 指定されたホスト以外は無視
  next unless row[0].to_s == myhost

  # 時刻の取得 (空白を T に置き換え, gnuplot が解釈に失敗するため)
  # 例 "2019-08-01 00:00:00" => "2019-08-01T00:00:00"
  time_list.push( row[1].gsub(' ','T') )

  # 欠損値か否かで分岐
  # mysqldump すると null が \\N に置換されている
  unless row[2] == "\\N"   
    # 10 分平均値は 3 番目のカラム (添字番号 2) に入っている.
    data_list.push( row[2].to_f ) 
  else
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
  set timefmt:  "%Y-%m-%dT%H:%M:%S"
  set format_x: "%m/%d %H:%M"
  set xrange:   "\"2019-08-28T09:00:00\"".."\"2019-08-30T09:00:00\""
  set xtics:    "rotate by -60"
  set terminal: "png"
  set output:   "#{output}"
  set :datafile, :missing, "999"    #欠損値
  
  plot time_list, data_list, using:'1:($2)', with:"linespoints", lc_rgb:"red", lw:2, title:"temp"
end
