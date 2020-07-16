<%@ page contentType="text/html;charset=UTF-8" %>
<script id="jquery_172" type="text/javascript" class="library" src="http://apps.bdimg.com/libs/jquery/1.9.1/jquery.min.js"></script>

<nav class="navbar navbar-default " role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="index.jsp" style="font-weight: bold">iTravel</a>
        </div>

        <ul class="nav navbar-nav">
            <li><a href="index.jsp">主页</a></li>
            <li><a href="search.jsp">搜索</a></li>
            <li><a href="#">其他</a></li>
        </ul>

        <ul class="nav navbar-nav navbar-right">
            <%
                if (session.getAttribute("username") != null) {
                    String name = (String) session.getAttribute("username");
            %>
            <li class="dropdown">
                <a href="#"> <span class="glyphicon glyphicon-user"></span> 欢迎 <%=name%></a>
                <ul class="dropdown-menu">
                    <li><a href="/myfavour">我的收藏</a></li>
                    <li><a href="upload.jsp">上传图片</a></li>
                    <li><a href="/myPhoto">我的图片</a></li>
                    <li><a href="myfriend.jsp">我的好友</a></li>
                </ul>
            </li>
            <li><a href="./logout"><span class="glyphicon glyphicon-log-out"></span> 登出</a></li>
            <%
            } else {
            %>
            <li><a href="register.jsp"><span class="glyphicon glyphicon-user"></span> 注册</a></li>
            <li><a href="login.jsp"><span class="glyphicon glyphicon-log-in"></span> 登录</a></li>
            <%
                }
            %>
        </ul>
    </div>
</nav>
<script>

    $('li.dropdown').mouseover(function () {
        $(this).addClass('open');
    }).mouseout(function () {
        $(this).removeClass('open');
    });

</script>
