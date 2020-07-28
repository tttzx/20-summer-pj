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
    <link rel="stylesheet" href="./css/Details.css">
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
    <%--<img src="travel-images/large/<%=picture.getPath()%>" alt="picture" id="picture" style="width: 100%">--%>
    <div class="picture">
        <div class="wrap" id="wrap">
            <div id="small">
                <img src="travel-images/large/<%=picture.getPath()%>" alt="">
                <div id="move"></div>
            </div>
            <div id="big" style="display: none">
                <img src="travel-images/large/<%=picture.getPath()%>" alt="">
            </div>
        </div>
    </div>
    <div id="info">
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

<script>
    //1.
    var oWrap = document.getElementById('wrap');
    var smallDiv = document.getElementById('small');
    var move = document.getElementById('move');
    var bigDiv = document.getElementById('big');

    //2.
    smallDiv.onmousemove = function (ev) {
        var oEvent = ev || event;
        var iScrollTop = document.documentElement.scrollTop || document.body.scrollTop;
        var iScrollLeft = document.documentElement.scrollLeft || document.body.scrollLeft;
        var disX = oEvent.clientX + iScrollLeft - move.offsetWidth / 2 - oWrap.offsetLeft;
        var disY = oEvent.clientY + iScrollTop - move.offsetHeight / 2 - oWrap.offsetTop;
        //console.log("oWrap.offsetLeft:"+oWrap.offsetLeft)
        if (disX < 0) {
            disX = 0;
        } else if (disX > smallDiv.offsetWidth - move.offsetWidth) {
            disX = smallDiv.offsetWidth - move.offsetWidth;
        }
        if (disY < 0) {
            disY = 0;
        } else if (disY > smallDiv.offsetHeight - move.offsetHeight) {
            disY = smallDiv.offsetHeight - move.offsetHeight;
        }
       // console.log("disX:" + disX);
        move.style.left = disX + 'px';
        move.style.top = disY + 'px';
        /*算出move块在X轴的移动距离与总的移动距离的比例*/
        var _pageX = disX / (smallDiv.offsetWidth - move.offsetWidth);
        //console.log("_pageX:" + _pageX);
        /*这是一个0~1之间的数*/
        /*算出move块在Y轴的移动距离与总的移动距离的比例*/
        var _pageY = disY / (smallDiv.offsetHeight - move.offsetHeight);
       // console.log("_pageY:" + _pageY);
        /*这是一个0~1之间的数*/
        /*求出大图片在X轴的移动距离*/
        var mX = _pageX * (bigDiv.children[0].offsetWidth - bigDiv.offsetWidth);
        // console.log(mX);
        /*求出大图片在Y轴的移动距离*/
        var mY = _pageY * (bigDiv.children[0].offsetHeight - bigDiv.offsetHeight);
        bigDiv.children[0].style.left = -mX + 'px';
        bigDiv.children[0].style.top = -mY + 'px';
    };

    //3.
    smallDiv.onmouseover = function (ev) {
        bigDiv.style.display = 'block';
        move.style.display = 'block';
        smallDiv.onmousemove(); //兼容IE
    };
    smallDiv.onmouseout = function () {
        bigDiv.style.display = 'none';
        move.style.display = 'none';
    };
</script>
</body>
</html>
