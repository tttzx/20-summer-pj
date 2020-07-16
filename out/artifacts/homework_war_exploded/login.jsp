<%--
  Created by IntelliJ IDEA.
  User: surface
  Date: 2020/7/8
  Time: 23:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="navbar.jsp" %>
<div class="container">
    <div class="page-header">
        <h1>请登录：</h1><br>
    </div>
    <form action="./login" method="post" onsubmit="return checkLogin()" class="form-horizontal" role="form">
        <div class="form-group">
            <label class="col-sm-2 control-label">Email/Username:</label>
            <div class="col-sm-5">
                <input type="text" name="message" class="form-control" id="message"  placeholder="enter email/username"
                       required><br>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">Password:</label>
            <div class="col-sm-5">
                <input type="password" name="password" class="form-control" id="password"  placeholder="enter password"
                       required> <br>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-5">
                <button type="submit" class="btn btn-primary">Submit</button>
            </div>
        </div>
    </form>
    <div class="col-sm-offset-1 col-sm-10">
        <a href="register.jsp">没有账号？注册一个吧</a>
    </div>
</div>
<script>
    function checkLogin() {
        var status = false;
        var message = $('#message').val();
        var password = $('#password').val();
        $.ajax({
            type: "post",
            async: false,
            url: "./loginCheck",
            data: {"message": message, "password": password},
            timeout: 30000,
            data_type: 'json',
            success: function (data) {
                if (data === "OK") {
                    status = true;
                } else if (data === "NO") {
                    status = false;
                } else {
                    status = false;
                }
            }
        });
        if(status){
            return true;
        }else {
            alert("用户名或密码错误");
            $('#password').val("");
            return false;
        }
    }


</script>
</body>
</html>
