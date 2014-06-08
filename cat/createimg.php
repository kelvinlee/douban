<?php
	ini_set('date.timezone','Asia/Shanghai');

  $db_config["hostname"]    = "localhost";    //服务器地址 
  $db_config["username"]    = "root";        //数据库用户名 
  $db_config["password"]    = "";        //mysql@lhq 数据库密码 
  $db_config["database"]    = "test";        //数据库名称 
  $db_config["charset"]        = "utf8"; 
  include('function.php');
  include('mysql.class.php'); 

  function echoRet( $ret ){ die( json_encode($ret) ); }


	$data = $_POST['data'];
	$data = base64_decode($data);
	$name = time()."_".rand(100,999);

	file_put_contents("./upload/".$name.".png",$data);


	$db = new db(); 
  $db->connect($db_config); 

	$info['url'] = "upload/".$name.".png";
  $info['date'] = date("Y-m-d H:i:s");
  $s = $db->row_insert('share-mengchong',$info);

	$ret['msg'] = '成功.';
  $ret['state'] = 'success';
  $ret['id'] = $db->insert_id();
  echoRet( $ret );
?>