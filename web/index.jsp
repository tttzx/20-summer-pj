<%@ page import="Entity.Picture" %>
<%@ page import="java.util.List" %>
<%@ page import="DAO.PictureDAO" %><%--
  Created by IntelliJ IDEA.
  User: surface
  Date: 2020/7/9
  Time: 14:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>iTravel</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="jumbotron text-center" style="margin:0">
    <h1>Welcome to iTravel!</h1>
</div>
<%@include file="navbar.jsp" %>
<!-- 轮播 -->
<div class="container" style="height: 500px">
    <div id="myCarousel" class="carousel slide" style="height: 500px">
        <!-- 轮播（Carousel）指标 -->
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>
        <!-- 轮播（Carousel）项目 -->
        <div class="carousel-inner" style="height: 500px">
            <%
                List<Picture> pictureList = PictureDAO.getHotPic();
            %>
            <div class="item active">
                <img src="travel-images/large/<%=pictureList.get(0).getPath()%>" alt="First slide" style="text-align: center">
                <div class="carousel-caption"><%=pictureList.get(0).getTitle()%></div>
            </div>
            <div class="item">
                <img src="travel-images/large/<%=pictureList.get(1).getPath()%>" alt="Second slide" style="text-align: center">
                <div class="carousel-caption"><%=pictureList.get(1).getTitle()%></div>
            </div>
            <div class="item">
                <img src="travel-images/large/<%=pictureList.get(2).getPath()%>" alt="Third slide" style="text-align: center">
                <div class="carousel-caption"><%=pictureList.get(2).getTitle()%></div>
            </div>

        </div>
        <!-- 轮播（Carousel）导航 -->
        <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</div>
<hr>
<div class="container">

    <h3><span class="glyphicon glyphicon-fire"></span> Some hot photos:</h3>
    <hr>
    <div class="row">
        <%
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
                </div>
            </div>
        </div>
        <%
            }
        %>

    </div>

    <h3><span class="glyphicon glyphicon-open"></span> Some new photos:</h3>
    <hr>
    <div class="row">
        <%
            List<Picture> pictureList1 = PictureDAO.getNewPic();
            for (Picture picture : pictureList1) {

        %>
        <div class="col-md-3">
            <div class="card " style="width:200px;height: 400px">
                <img class="card-img-top" src="travel-images/square-medium/<%=picture.getPath()%>" style="width:100%">
                <div class="card-body">
                    <h4 class="card-title"><%=picture.getTitle()%>&nbsp;<span class="label label-danger">NEW!</span></h4>
                    <p class="card-text">Author:<%=picture.getAuthor()%></p>
                    <p class="card-text">Content:<%=picture.getContent()%></p>
                    <p class="card-text">收藏人数:<%=picture.getLikePerson()%></p>
                    <a href="/detail?id=<%=picture.getID()%>" class="btn btn-primary">详情</a>
                </div>
            </div>
        </div>
        <%
            }
        %>

    </div>
</div>

<footer class="footer">
    <div class="container">
        <p class="text-muted">Copyright by 18302010061</p>
    </div>
</footer>

</body>
</html>
