<%@ page import="Entity.Picture" %>
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
    <title>我的图片</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/Search.css" media="all">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="navbar.jsp" %>

<div class="container">
    <div class="title">
        <h3><span class="glyphicon glyphicon-saved"></span><strong> <%= session.getAttribute("username") %></strong> 的图片</h3></div>
    <hr>
    <%
        List<Picture> pictureList = (List<Picture>) request.getAttribute("myPictures");
        for (Picture picture : pictureList) {

    %>

    <div class="col-md-3">
        <div class="card " style="width:200px;height: 500px">
            <img class="card-img-top" src="travel-images/square-medium/<%=picture.getPath()%>" style="width:100%">
            <div class="card-body">
                <h4 class="card-title"><%=picture.getTitle()%></h4>
                <p class="card-text">Author:<%=picture.getAuthor()%></p>
                <p class="card-text">Content:<%=picture.getContent()%></p>
                <p class="card-text">收藏人数:<%=picture.getLikePerson()%></p>
                <a href="/detail?id=<%=picture.getID()%>" class="btn btn-primary">详情</a>
                <a href="#" id="delete" class="btn btn-default">删除图片</a>
                <%--<a href="/deleteFavor?imageID=<%=picture.getID()%>" class="btn btn-default">取消收藏</a>--%>
            </div>
        </div>
    </div>


    <%
        }
    %>

</div>
<script>
    $('#delete').click(function () {
        
    })
</script>
</body>
</html>
