<html>
<head><title>test tasuLife</title></head>
<body>
<table>

<li>
<?php
echo "PostgreSQLテスト",PHP_EOL;

$link = pg_connect("host=localhost dbname=test user=postgres password=1");

if(!$link){
	echo "DBに接続できません。";
}else{
	echo "DB接続成功！";
}

pg_close($link);
?>
</li>

<li><input type="file" name="ck01" value="1"></li>

</table>
</body>
</html>