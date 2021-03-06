<%--
  Created by IntelliJ IDEA.
  User: surface
  Date: 2020/7/9
  Time: 16:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>好友的收藏</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="navbar.jsp" %>

<div class="container">
    <div class="row">

        <div class="title">
            <h3><span class="glyphicon glyphicon-user"></span><strong>好友 <%= request.getAttribute("friendName") %>
            </strong>的收藏</h3>
        </div>
        <hr>
        <div id="favourResult">

        </div>


    </div>
</div>
<script type="text/javascript">
    var pageSize = 4;
    var totalCount;
    var totalPage;
    var result;
    var data = '<%=request.getAttribute("pictures")%>';
    result = JSON.parse(data).results;
    if (result !== null) {
        totalCount = result.length;
        totalPage = Math.ceil(totalCount / pageSize);
    }

    showFavourPage(1);


    function showFavourPage(page) {
        var str = "";
        if (result === null) {
            str="<p>TA暂时没有收藏图片哦<p>";
        } else if (result == "NO") {
            str="<p>对不起，该好友隐藏了自己的收藏！<p>";
        } else {
            for (var i = (page - 1) * pageSize; i < page * pageSize && i < result.length; i++) {
                str += "<div class=\"col-md-3\">\n" +
                    "            <div class=\"card \" style=\"width:200px;height: 400px\">\n" +
                    "                <img class=\"card-img-top\" src=\"travel-images/square-medium/" + result[i].PATH + "\" style=\"width:100%\">\n" +
                    "                <div class=\"card-body\">\n" +
                    "                    <h4 class=\"card-title\">" + result[i].Title + "</h4>\n" +
                    "                    <p>作者：" + result[i].Author + "</p>\n" +
                    "                    <p>收藏人数：" + result[i].likeperson + "</p>\n" +
                    "                    <a href=\"/detail?id=" + result[i].ImageID + "\" class=\"btn btn-primary\">详情</a>\n" +
                    "                </div>\n" +
                    "            </div>\n" +
                    "        </div>";
            }

            str += "<div class='row'>" +
                "<nav  class='col-md-5 col-md-offset-4' aria-label=\"Page navigation\" >\n" +
                "            <ul class=\"pagination \">\n";

            for (var i = 1; i <= totalPage; i++) {
                if (page === i) {
                    str += "<li class='active'><a>" + i + "</a></li>";
                } else {
                    str += "<li><a href='javascript:showFavourPage(" + i + ");'>" + i + "</a></li>";
                }
            }

            str +="        </ul>\n" +
                "        </nav>" +
                "</div>";
        }
        $('#favourResult').empty().html(str);
    }
</script>
</body>
</html>
