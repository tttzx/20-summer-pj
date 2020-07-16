<%--
  Created by IntelliJ IDEA.
  User: surface
  Date: 2020/7/9
  Time: 0:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>

<body>
<%@include file="navbar.jsp" %>
<div class="container">
    <div class="page-header">
        <h1>注册账号：</h1><br>
    </div>
    <form action="./register" method="post" onsubmit="return check()" class="form-horizontal" role="form">
        <div id="nameGroup" class="form-group ">
            <label class="col-sm-2 control-label">Name:</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="name" name="name" placeholder="enter name"
                       onchange="checkName()" required><br>
            </div>
            <span id="helpBlock1" class="help-block"></span>
        </div>
        <div id="emailGroup" class="form-group">
            <label class="col-sm-2 control-label">E-mail:</label>
            <div class="col-sm-4">
                <input type="email" class="form-control" id="email" name="email" placeholder="enter email"
                       onchange="checkEmail()" required><br>
            </div>
            <span id="helpBlock2" class="help-block"></span>
        </div>
        <div id="passGroup" class="form-group">
            <label class="col-sm-2 control-label">Password:</label>
            <div class="col-sm-4">
                <input type="password" class="form-control" id="password" name="password" placeholder="enter password"
                       oninput="checkPassWord()" required> <br>
            </div>
            <span id="helpBlock3" class="help-block"></span>
        </div>
        <div id="rePassGroup" class="form-group">
            <label class="col-sm-2 control-label">ReEnter Password:</label>
            <div class="col-sm-4">
                <input type="password" class="form-control" id="rePassword" name="password" placeholder="enter password"
                       oninput="checkRePass()" required> <br>
            </div>
            <span id="helpBlock4" class="help-block"></span>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-4">
                <input type="submit" class="btn btn-primary"  value="提交">
            </div>
        </div>
    </form>
    <div class="col-sm-offset-1 col-sm-10">
        <a href="login.jsp">已有账号？去登陆吧</a>
    </div>
</div>

<script>
    var namecheck=false;
    function checkName() {
        var name = $("#name").val();
        var pattern = /^[a-zA-Z0-9_]{4,15}$/;
        if (pattern.test(name)) {
            $("#nameGroup").removeClass("has-error");
            $("#helpBlock1").html("");
            $.ajax({
                type: "post",
                async: false,
                url: "./checkName",
                data: {"name": name},
                timeout: 30000,
                data_type: 'json',
                success: function (data) {
                    if (data === "OK") {
                        $("#nameGroup").removeClass("has-error");
                        $("#helpBlock1").html("");
                        namecheck =true;
                    } else {
                        $("#nameGroup").addClass("has-error");
                        $("#helpBlock1").html("用户名已存在");
                        namecheck=false;
                    }
                }
            });
        } else {
            $("#nameGroup").addClass("has-error");
            $("#helpBlock1").html("用户名长度应当为 4 至 15 位");
           namecheck=false;
        }
    }

    function checkEmail() {
        var email = $("#email").val();
        var pattern = /^([A-Za-z0-9_\-.\u4e00-\u9fa5])+@([A-Za-z0-9_\-.])+\.([A-Za-z]{2,8})$/;
        if (pattern.test(email)) {
            $("#emailGroup").removeClass("has-error");
            $("#helpBlock2").html("");
            return true;
        } else {
            $("#emailGroup").addClass("has-error");
            $("#helpBlock2").html("请输入正确的邮箱地址");
            return false;
        }
    }


    function checkPassWord() {
        var password = $('#password').val();
        var passGroup = $('#passGroup');

        function getValue(password) {
            var value = 0;
            if (password.length >= 6 && password.length <= 12) {
                value = 1;
                for (var i = 0; i < password.length; i++) {
                    var current = password.charCodeAt(i);
                    //大写或小写字母
                    if (((current >= 65 && current <= 90) || (current >= 97 && current <= 122))) {
                        value = 2;
                    }
                    //特殊字符
                    if (((current >= 33 && current <= 47) || (current >= 58 && current <= 64) || (current >= 91 && current <= 96) || (current >= 123 && current <= 126)) && password.length >= 8) {
                        value = 3;
                        break;
                    }
                }
            }
            return value;
        }

        var value = getValue(password);
        if (value === 0) {
            $("#helpBlock3").html('密码需在6至12位');
            passGroup.removeClass("has-warning");
            passGroup.addClass("has-error");
            return false;
        } else if (value === 1) {
            $("#helpBlock3").html('低强度密码');
            passGroup.removeClass("has-error");
            passGroup.addClass("has-warning");
            return true;
        } else if (value === 2) {
            $("#helpBlock3").html('中强度密码');
            passGroup.removeClass("has-warning");
            passGroup.removeClass("has-error");
            return true;
        } else if (value === 3) {
            $("#helpBlock3").html('<p style="color: green">高强度密码 <span class="glyphicon glyphicon-ok"></span></p>');
            passGroup.removeClass("has-warning");
            passGroup.removeClass("has-error");
            return true;
        }
    }

    function checkRePass() {
        var password = $('#password').val();
        var rePassword = $('#rePassword').val();
        if (rePassword === password) {
            $("#rePassGroup").removeClass("has-error");
            $("#helpBlock4").html("");
            return true;
        } else {
            $("#rePassGroup").addClass("has-error");
            $("#helpBlock4").html("两次密码输入不一致");
            return false;
        }
    }

    function check() {
        console.log(namecheck);
        console.log(checkEmail());
        console.log(checkPassWord());
        console.log(checkRePass());
        if (namecheck && checkEmail() && checkPassWord() && checkRePass()) {
            return true;
        } else {
            alert("请正确填写信息");
            return false;
        }
    }

</script>
</body>
</html>
