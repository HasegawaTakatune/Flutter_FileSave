<?php
require_once('config.php');

$link = pg_connect(DATABASE_PARAMETAR);

$message = '';
$isSuccess = true;
$result = array();	

if(!$link){
	//die('DBに接続できません。'.pg_last_error());
	$message = 'DBに接続できません。'.pg_last_error();
	$isSuccess = false;
}else{
	$data = pg_query('SELECT * FROM ANIMALS_BOOK');
	if(!$data){
		//die('クエリが失敗しました。'.pg_last_error());
		$message = 'クエリが失敗しました。'.pg_last_error();
		$isSuccess = false;	

		$result[] = array(
			MSG=>$message,
			IS_SUCCESS=>$isSuccess
		);
	}else{		
		while($row = pg_fetch_array($data,NULL,PGSQL_ASSOC)){
			$result[]=array(
			NAME=>$row[NAME],
			SCIENCE_NAME=>$row[SCIENCE_NAME],
			CLASSIFIC=>$row[CLASSIFIC],
			CLASSIFIC_DETAILS=>$row[CLASSIFIC_DETAILS],
			DISTRIB=>$row[DISTRIB],
			MI_LEN=>$row[MI_LEN],
			MX_LEN=>$row[MX_LEN],
			UP_DAY=>$row[UP_DAY],
			MSG=>$message,
			IS_SUCCESS=>$isSuccess
			);
		}
	}
	
	header('Content-type: application/json; charset=utf8');
	$data_json = json_encode($result,JSON_UNESCAPED_UNICODE);
	echo $data_json;	
}

pg_close($link);
?>