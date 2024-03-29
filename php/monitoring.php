<?php
/*
表題: データベースにモニタリングの結果を入力するための PHP スクリプト
*/

// 設定ファイル
require_once("/home/user/iotex-server/conf/db_info.php");

//変数初期化
$table  = "monitoring";           //テーブル名
$table2 = "monitoring_hosts";     //テーブル名
$ip     = getenv("REMOTE_ADDR"); //送信元 IP で初期化

//取得したデータ (1)
//$essid= htmlspecialchars($_GET["essid"]);
$host = htmlspecialchars($_GET["hostname"]);
if (htmlspecialchars($_GET["time"])){
  $time = htmlspecialchars($_GET["time"]);
}else{
  $time = date("YmdHis");
}
//echo $essid;
//echo $host;
//echo $time;


//取得したデータの一覧を作成
$data  = '';         // 初期化
$data2 = '';         // 初期化
$keys = array("temp","temp2","temp3","humi","humi2","humi3","dp","dp2","dp3","bmptemp","dietemp","lux","objtemp","pres","sitemp","sihumi","eco2","tvoc"); //カラム名
//echo $keys;
for ($i =0; $i < count($keys); $i++){
  //データをカンマ区切りで並べる. 
  if (isset($_GET[$keys[$i]]) and (preg_match("/^[0-9]+/", $_GET[$keys[$i]]))){
    // 値があるときはそのまま
    $data  = $data.sprintf('%.2f',$_GET[$keys[$i]]);
    $data2 = $data2.sprintf('%s=%.2f',$keys[$i],$_GET[$keys[$i]]);
  }else{
    // 値が無いときは null に. 
   $data  = $data."null";
   $data2 = $data2.sprintf('%s=null',$keys[$i]);
  }
  // カンマ区切りを入れる
  if ($i != (count($keys)-1)){
    $data  = $data.",";
    $data2 = $data2.",";
  }
}

//データベースへ接続
try{ 
  $s= new PDO("mysql:host=$SERV;dbname=$DBNM", $USER, $PASS);
  $s->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 

  // データ入力
  $query = sprintf(
   'insert into %s (hostname,time,temp,temp2,temp3,humi,humi2,humi3,
    dp,dp2,dp3,bmptemp,dietemp,lux,objtemp,pres,sitemp,sihumi,eco2,tvoc) values( "%s","%s",%s )  ON DUPLICATE KEY UPDATE %s',
    $table,$host,$time,$data,$data2
  );

  echo $query;
  $s->query( $query );

}catch(PDOException $e){
  print "ERROR: ";
  print $e->getMessage();
}

// IP とホスト名の組みを作る
try{ 
  $query = sprintf(
  'INSERT INTO %s VALUES("%s","%s","%s") ON DUPLICATE KEY UPDATE ip="%s",time="%s"',
  $table2,$host,$ip,$time,$ip,$time);

  echo $query;  
  $re=$s->query( $query );
  
}catch(PDOException $e){
  print "ERROR: ";
  print $e->getMessage();
}
  
?>
