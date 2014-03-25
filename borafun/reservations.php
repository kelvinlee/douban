<?php 
    ini_set('date.timezone','Asia/Shanghai');

    $db_config["hostname"]    = "mconnect.mysql.rds.aliyuncs.com";    //服务器地址 
    $db_config["username"]    = "mconnect";        //数据库用户名 
    $db_config["password"]    = "mconnectNB";        //数据库密码 
    $db_config["database"]    = "minsite_register";        //数据库名称 
    $db_config["charset"]        = "utf8"; 
    include('function.php');
    include('mysql.class.php'); 

    //check everyone
    function echoRet( $ret ){ die( json_encode($ret) ); }
    if( empty($_POST['mobile']) || empty($_POST['name']) ){
        $ret['msg'] = '信息不全,请补充！';
        $ret['state'] = 'empty';
        echoRet( $ret );
        return false;
    }
    if ( !is_numeric($_POST["mobile"]) && strlen($_POST["mobile"]) == 11 ) {
        $ret['msg'] = '手机号填写错误！';
        $ret['state'] = 'not number';
        echoRet( $ret );
        return false;
    }

    //connect to db
    $db    = new db(); 
    $db->connect($db_config); 
    
    $row = $db->row_select('bora-kelvin-fun', 'mobile='.gl($_POST['mobile']));
    // check mobile number. 
    if ($row) {
        $ret['msg'] = '您已经预约过了.';
        $ret['state'] = 'already';
        echoRet( $ret );
    }else{
        $data['username'] = gl($_POST['name']);
        $data['mobile'] = gl($_POST['mobile']);
        // $data['email'] = gl($_POST['email']);
        // $data['sex'] = gl($_POST['sex']);
        $data['province'] = gl($_POST['province']);
        $data['city'] = gl($_POST['city']);
        $data['dealer'] = gl($_POST['dealer']); 
        $data['buytime'] = gl($_POST['buytime'])?gl($_POST['buytime']):"不确定";  
        $data['cartype'] = gl($_POST['cartype'])?gl($_POST['cartype']):"";  
        $data['hope'] = gl($_POST['hope'])?gl($_POST['hope']):"宝来"; 
        $data['selcar'] = gl($_POST['selcar']);
        $data['date'] = date("Y-m-d H:i:s");

        $s = $db->row_insert('bora-kelvin-fun',$data);
        // print_r($s);

        $ret['msg'] = '预约成功.';
        $ret['state'] = 'success';
        echoRet( $ret );
    }
    return false;

?> 