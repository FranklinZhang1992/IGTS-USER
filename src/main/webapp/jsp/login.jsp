<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" errorPage=""%>
<!DOCTYPE html>
<html lang="zh-cn">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login</title>
<%
    String baseURL = request.getContextPath();
%>
    <!-- Bootstrap -->
    <link href="<%=baseURL%>/static/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
        .container-login
        {   margin-top: 120px;}
        .form-box
        {   border-style: solid;
            border-color: gray;
            border-width: 1px;
            padding: 20px;}
        .flushInfo {
    color: red;
    top: 10px;
    right: 10px;
    position: fixed;
    border: solid 1px #B9B0B0;
    background-color: #fff;
    width: 0px;
    height: 0px;
    border-radius: 8px;
    line-height: 40px;
    text-align: center;
    z-index: 10000;
}
.alert-position{
    top: 10px;
    right: 10px;
}
    </style>
    
  </head>
  <body>
    <div class="container container-fluid container-login">
        <div class="row">
            <div class="col-sm-9">
                <div class="jumbotron">
                    <h1>剁手网</hi>
                    <p>闲置物品交易系统</p>
                </div>
            </div>
            <div class="col-sm-3">
                <form role="form" class="form-box" id="myPopover">
                    <div class="form-group">
                        <h4>登录</h4>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputID">用户名</label>
                        <input type="text" class="form-control" id="userName" placeholder="输入用户名">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword">密码</label>
                        <input type="password" class="form-control" id="password" placeholder="输入密码">
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox"> 保存密码
                        </label>
                    </div>
                    <button type="button" class="btn btn-primary btn-block">登录</button>
                </form>
            </div>
        </div>
    </div>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="<%=baseURL%>/webjars/jquery/2.1.3/jquery.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="<%=baseURL%>/static/js/bootstrap.min.js"></script>
    <script src="<%=baseURL%>/static/js/base.js"></script>
<script type="text/javascript">
    var contextURL = '<%= baseURL%>/api';
</script>
  </body>
</html>
