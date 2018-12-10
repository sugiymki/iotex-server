<?php
/*
表題: データベースにモニタリングの結果を入力するための PHP スクリプト
履歴: 2018-09-12 杉山耕一朗
      2018-11-20 杉山耕一朗
*/

// 設定ファイル
require_once("/home/sugiyama/conf/db_info.php");

//変数初期化
$table  = "iotex2018";           //テーブル名
$table2 = "iotex2018_hosts";     //テーブル名
$ip     = getenv("REMOTE_ADDR"); //送信元 IP で初期化

//取得したデータ (1)
$essid= htmlspecialchars($_GET["essid"]);
$host = htmlspecialchars($_GET["hostname"]);
$time = htmlspecialchars($_GET["time"]);
echo $essid;
echo $host;
echo $time;


//取得したデータの一覧を作成
$data = '';         // 初期化
$keys = array("temp", "temp2", "temp3", "humi", "humi2", "humi3", "dp", "dp2", "dp3", "bmptemp", "dietemp", "lux", "objtemp", "pres"); //カラム名
for ($i =0; $i < count($keys); $i++){
  //データをカンマ区切りで並べる. 
  if (preg_match("/^[0-9]+/", $_GET[$keys[$i]])){
    // 値があるときはそのまま
    $data = $data.sprintf('%.2f',$_GET[$keys[$i]]);
  }else{
    // 値が無いときは null に. 
   $data = $data."null";
  }
  // カンマ区切りを入れる
  if ($i != (count($keys)-1)){
    $data = $data.",";
  }
}

//データベースへ接続
try{ 
  $s= new PDO("mysql:host=$SERV;dbname=$DBNM", $USER, $PASS);
  $s->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 

  // データ入力
  $query = sprintf(
   'insert into %s (hostname,time,temp,temp2,temp3,humi,humi2,humi3,
    dp,dp2,dp3,bmptemp,dietemp,lux,objtemp,pres) values( "%s","%s",%s )',
    $table,$host,$time,$data
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
  'INSERT INTO %s VALUES("%s","%s","%s","%s") ON DUPLICATE KEY UPDATE ip="%s",time="%s",essid="%s"',
  $table2,$ip,$host,$time,$essid,$ip,$time,$essid);

  echo $query;  
  $re=$s->query( $query );
  
}catch(PDOException $e){
  print "ERROR: ";
  print $e->getMessage();
}
  
?>
