<%@ page import="Entity.User" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: surface
  Date: 2020/7/9
  Time: 16:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的好友</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="navbar.jsp" %>
<%
    if (session.getAttribute("username") == null) {

%>
<p>请先登录</p>
<%
} else{
%>

<div class="container">
    <div class="title"><h3><span class="glyphicon glyphicon-user"></span> 好友</h3></div>
    <hr>

    <div class="row">
        <div class="col-md-5">
            <div class="row">
                <div class="title"><h4><span class="glyphicon glyphicon-th-list"></span>好友列表</h4></div>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>
                            用户名
                        </th>
                        <th>
                            邮箱
                        </th>
                        <th>
                            注册时间
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        List<User> friends = (List<User>) request.getAttribute("myFriends");
                        if (friends != null)
                            for (User user : friends) {
                    %>
                    <tr>
                        <td>
                            <a href="/friendFavor?friendName=<%=user.getUserName()%>"><%=user.getUserName()%>
                            </a>
                        </td>
                        <td>
                            <%=user.getEmail()%>
                        </td>
                        <td>
                            <%=user.getDateJoined()%>
                        </td>
                    </tr>
                    <%
                            }
                    %>
                    </tbody>

                </table>
            </div>

            <div class="row">
                <div class="title"><h4><span class="glyphicon glyphicon-indent-left"></span>待处理好友请求</h4></div>
                <ul class="list-group">
                    <%
                        List<User> receive = (List<User>) request.getAttribute("requestIReceived");
                        if (receive != null)
                            for (User user : receive) {
                    %>
                    <li class="list-group-item"><%=user.getUserName()%>
                        <a href="/agree?id=<%=user.getID()%>" class="btn btn-default">同意</a>
                        <a href="/reject?id=<%=user.getID()%>" class="btn btn-default">拒绝</a>
                    </li>
                    <%
                            }
                    %>
                </ul>
            </div>

            <div class="row">
                <div class="title"><h4><span class="glyphicon glyphicon-indent-right"></span>已发送的好友请求</h4></div>
                <ul class="list-group">
                    <%
                        List<User> send = (List<User>) request.getAttribute("requestISent");
                        if (send.size() > 0)
                            for (User user : send) {
                    %>
                    <li class="list-group-item"><%=user.getUserName()%>
                    </li>
                    <%
                            }
                    %>
                </ul>
            </div>
        </div>
        <div class="col-md-6 col-md-offset-1">
            <div class="row">
                <div class="title"><h4><span class="glyphicon glyphicon-search"></span>添加好友</h4></div>
                <hr>
                <form action="/myFriend" method="post">
                    <div class="input-group">
                        <input type="text" name="text" id="text" class="form-control" placeholder="Search for..."
                               required>
                        <span class="input-group-btn">
                    <input class="btn btn-default" type="submit" id="submit" value="搜索">
                </span>
                    </div>
                </form>
            </div>
            <div id="result">
                <div class="row">
                    <%
                        List<User> results = (List<User>) request.getAttribute("results");
                        if (results != null)
                            for (User user : results) {
                    %>
                    <div class="col-md-3">
                        <div class="card " style="padding: 5px">
                            <img class="card-img-top" src="travel-images/img_avatar.png"
                                 alt="Card image" style="width:100%">
                            <div class="card-body">
                                <h4 class="card-title"><%=user.getUserName()%>
                                </h4>
                                <p>
                                    <small><%=user.getEmail()%>
                                    </small>
                                </p>
                                <a href="/sendFriendRequest?id=<%=user.getID()%>" class="btn btn-primary">发送请求</a>
                            </div>
                        </div>
                    </div>
                    <%
                            }
                    %>

                </div>
            </div>
        </div>
    </div>
</div>
<%
    }
%>

</body>
</html>
