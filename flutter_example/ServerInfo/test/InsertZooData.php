<?php
require_once('config.php');

mb_language('uni');
mb_internal_encoding('utf-8');
mb_http_input('auto');
mb_http_output('utf-8');

$json = file_get_contents('php://input');
$contents = json_decode($json,true);

$link = pg_connect(DATABASE_PARAMETAR);

$message = 'None';
$isSuccess = true;

if(!$link){    
    //die('DBに接続できません。'.pg_last_error());
    $message = 'DBに接続できません。'.pg_last_error();
    $isSuccess = false;
}else{	
	$name = $contents[NAME]; //'ピューマ';
	$scientific_name = $contents[SCIENCE_NAME]; //'Felis catus';
	$classification = $contents[CLASSIFIC]; //'ほ乳類';
	$classification_details = $contents[CLASSIFIC_DETAILS]; //'食肉目裂脚亜目ネコ科';
	$distribution = $contents[DISTRIB]; //'カナダ南部から南アメリカ';
	$min_length = $contents[MI_LEN]; //100;
	$max_length = $contents[MX_LEN]; //197;
	$updateday = $contents[UP_DAY]; //date('y/m/d H:i:s');
	
	$query = 'INSERT INTO ANIMALS_BOOK VALUES(\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\')';
	$order = sprintf($query,$name,$scientific_name,$classification,$classification_details,$distribution,$min_length,$max_length,$updateday);
	$res = pg_query($order);
	if(!$res){
        //die('クエリが失敗しました。'.pg_last_error());
        $message = 'クエリが失敗しました。'.pg_last_error();
        $isSuccess = false;
    }
}

$result = array();
$result[] = array(
    MSG=>$message,
    IS_SUCCESS=>$isSuccess
);

header('Content-type: application/json; charset=utf8');
$data_json = json_encode($result,JSON_UNESCAPED_UNICODE);
echo $data_json;

pg_close($link);
?>