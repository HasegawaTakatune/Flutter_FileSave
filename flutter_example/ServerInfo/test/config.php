<?php

// データベース接続情報
define('DATABASE_HOST','localhost');
define('DATABASE_NAME','postgres');
define('DATABASE_USER','postgres');
define('DATABASE_PASSWORD','1');

define('DATABASE_PARAMETAR','host=' . DATABASE_HOST . ' dbname=' . DATABASE_NAME . ' user=' . DATABASE_USER . ' password=' . DATABASE_PASSWORD);

// 動物データ一覧
// 名前
define('NAME','name');
// 学名
define('SCIENCE_NAME','scientific_name');
// 分類
define('CLASSIFIC','classification');
// 分類詳細
define('CLASSIFIC_DETAILS','classification_details');
// 分布
define('DISTRIB','distribution');
// 最小全長
define('MI_LEN','min_length');
// 最大全長
define('MX_LEN','max_length');
// 更新日時
define('UP_DAY','updateday');

// リザルトデータ
// 成功
define('IS_SUCCESS','is_success');
// メッセージ
define('MSG','message');
?>