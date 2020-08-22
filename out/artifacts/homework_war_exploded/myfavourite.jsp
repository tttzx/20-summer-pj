<%@ page import="Entity.Picture" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: surface
  Date: 2020/7/9
  Time: 16:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的收藏</title>
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
    <div class="row">
        <div class="col-md-9">
            <div class="title">
                <h3><span class="glyphicon glyphicon-user"></span><strong><%= session.getAttribute("username") %>
                </strong>的收藏</h3>
            </div>
            <hr>
            <div class="row">
                <h5 class="col-md-2">允许好友查看：</h5>
                <input type="checkbox" name="my-checkbox" checked>

                <select class="col-md-10 form-control" id="limit" style="width: 10%" name="limit"
                        onchange="changeState()">
                    <%
                        String limit = (String) request.getAttribute("limit");
                        if (limit != null) {
                            if (limit.equals("1")) {
                    %>
                    <option value="1" selected>是</option>
                    <option value="0">否</option>
                    <%
                    } else {
                    %>
                    <option value="1"> 是</option>
                    <option value="0" selected> 否</option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
            <hr>
            <div id="favourResult">

            </div>
        </div>

        <div class="col-md-3">

            <div class="panel panel-default">
                <!-- Default panel contents -->
                <div class="panel-heading"><strong>我的足迹</strong></div>
                <% List<Picture> pictures = (List<Picture>) request.getAttribute("footprint");
                    if (pictures != null) {
                        for (Picture picture : pictures) {
                %>
                <a href="/detail?id=<%=picture.getID()%>" class="list-group-item">
                    <%=picture.getTitle()%>
                </a>
                <%
                        }
                    }
                %>
            </div>
        </div>

    </div>
</div>
<script type="text/javascript">
    $('input[name="my-checkbox"]').bootstrapSwitch({
        "onColor" : "success",
        "offColor" : "success",
        "onText" : "男",
        "offText" : "女"
    });

    var pageSize = 3;
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
            str="<p>你还没有收藏过图片哦……<p>";
        } else {
            for (var i = (page - 1) * pageSize; i < page * pageSize && i < result.length; i++) {
                str += "<div class=\"col-md-4\">\n" +
                    "            <div class=\"card \" style=\"width:200px;height: 400px\">\n" +
                    "                <img class=\"card-img-top\" src=\"travel-images/square-medium/" + result[i].PATH + "\" style=\"width:100%\">\n" +
                    "                <div class=\"card-body\">\n" +
                    "                    <h4 class=\"card-title\">" + result[i].Title + "</h4>\n" +
                    "                    <p>作者：" + result[i].Author + "</p>\n" +
                    "                    <p>收藏人数：" + result[i].likeperson + "</p>\n" +
                    "                    <a href=\"/detail?id=" + result[i].ImageID + "\" class=\"btn btn-primary\">详情</a>\n" +
                    "                    <a href=\"/deleteFavor?imageID=" + result[i].ImageID + "\" class=\"btn btn-default\">取消收藏</a>" +
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

    function changeState() {
        var limit = $("#limit").val();
        $.ajax({
            type: "post",
            async: false,
            url: "/changeState",
            data: {"limit": limit},
            data_type: 'json',
            success: function (data) {
                alert("修改成功！");
            }
        })
    }
</script>
<%
    }
%>
</body>
</html>
