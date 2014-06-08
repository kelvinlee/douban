<!DOCTYPE html>
<html lang="en" class="no-js">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <link rel="apple-touch-icon" href="img/thumb.jpg">
    <meta name="viewport" content="target-densitydpi=device-dpi,width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <title>好友分享萌宠</title>
    <link rel="stylesheet" href="css/main.css">
    <script src="js/libs/easeljs-0.7.1.min.js"></script>
    <script src="js/libs/tweenjs-0.5.1.min.js"></script>
    <script src="js/libs/movieclip-0.7.1.min.js"></script>
    <script src="js/libs/preloadjs-0.4.1.min.js"></script>
    <script src="js/libs/soundjs-0.5.2.min.js"></script>
  </head>
<?php
  ini_set('date.timezone','Asia/Shanghai');

  $db_config["hostname"]    = "localhost";    //服务器地址 
  $db_config["username"]    = "root";        //数据库用户名 
  $db_config["password"]    = "";        //mysql@lhq 数据库密码 
  $db_config["database"]    = "test";        //数据库名称 
  $db_config["charset"]        = "utf8"; 

  include('function.php');
  include('mysql.class.php');
  $db    = new db(); 
  $db->connect($db_config); 
  
  $row = $db->row_select('share-mengchong', 'id='.gl($_GET['id']));
?>
  <body onload="">
    <div class="fifth"><a href="index.html"><img src="<?php echo $row[0]["url"]?>" class="pet"></a><img src="img/share-bg.jpg">
      <div class="sharebtn"><img src="img/sharebtn.png"></div>
    </div>
    <script src="js/main.js"></script>
  </body>
</html>