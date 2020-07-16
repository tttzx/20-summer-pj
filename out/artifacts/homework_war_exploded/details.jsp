<%@ page import="Entity.Picture" %>
<%@ page import="DAO.PictureDAO" %><%--
  Created by IntelliJ IDEA.
  User: surface
  Date: 2020/7/9
  Time: 19:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>详情</title>
    <title>搜索</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="navbar.jsp" %>
<%
    Picture picture = (Picture) request.getAttribute("picture");
%>
<div class="container">
    <div class="title">
        <h3><span class="glyphicon glyphicon-user"></span><strong>图片详情</strong></h3>
    </div>
    <hr>
    <div class="row">
        <div class="col-lg-4">
            <img src="travel-images/large/<%=picture.getPath()%>" alt="picture" id="picture" style="width: 100%">
        </div>
        <div class="col-lg-7 col-lg-offset-1">
            <h1 style="font:italic 3em Georgia, serif;"><%=picture.getTitle()%>
            </h1>
            <p>From <%=picture.getAuthor()%>
            </p>
            <hr>
            <p>收藏人数：<%=picture.getLikePerson()%>
            </p>
            <p>国家：<%=picture.getCountryName()%>
            </p>
            <p>地区：<%=picture.getCityName()%>
            </p>
            <p>内容：<%=picture.getContent()%>
            </p>
            <hr>
            <h4 style="color: darkgray">>>More information</h4>
            <p style="color: darkgray"><%=picture.getDescription()%>
            </p>

            <%
                if (session.getAttribute("username") != null) {
                    if (PictureDAO.alreadyFavoured((String) session.getAttribute("username"), request.getParameter("id"))) {
            %>
            <button class="btn" style="cursor: not-allowed">您已收藏</button>
            <%
            } else {
            %>
            <form action="/addMyFavor" method="post">
                <input type="text" value="<%=picture.getID()%>" name="imageID" style="display: none">
                <button type="submit" class="btn btn-primary">收藏</button>
            </form>
            <%
                    }
                }
            %>
        </div>
    </div>


</div>

</body>
</html>
