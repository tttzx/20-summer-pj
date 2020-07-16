<%@ page import="Entity.Picture" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: surface
  Date: 2020/7/9
  Time: 16:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>搜索</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="navbar.jsp" %>
<div class="container">
    <div class="row">
        <div class="page-header"><h1>搜索</h1></div>
    </div>
    <form onsubmit="return false;" class="form-horizontal" role="form">
    <div class="row" style="padding: 5px;">
        <div class="col-md-6">
            <div class="input-group">
                <input type="text" name="text" id="text" class="form-control" placeholder="Search for..." required>
                <span class="input-group-btn">
                    <input class="btn btn-default" type="submit" id="submit" value="搜索">
                </span>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-offset-1 col-md-6">
            <div class="radio">
                <label><input type="radio" name="type" value="title" checked>搜索标题</label>
                <label><input type="radio" name="type" value="content">搜索主题</label>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-offset-1 col-md-6">
            <div class="radio">
                <label><input type="radio" name="order" value="likeperson" checked>按热度排序</label>
                <label><input type="radio" name="order" value="imageID">按时间排序</label>
            </div>
        </div>
    </div>
    </form>


    <div class="row">
        <hr>
        <h4>搜索结果</h4>
        <hr>
    </div>

    <div id="resultPart">

    </div>


</div>
</body>
<script type="text/javascript">
    var pageSize = 8;
    var totalCount;
    var totalPage;
    var result;

    function showPage(page) {
        var str = "";
        if (result===null) {
            str = '<div class="row">\n' +
                '        <p class="text-muted">抱歉，没有找到相关图片。</p>\n' +
                '        </div>';
        } else {
            str = '<div class="row">\n' +
                '        <p class="text-muted">共找到<strong> '+totalCount+' </strong>个结果：</p>\n' +
                '        </div>';
            for (var i = (page - 1) * pageSize; i < page * pageSize && i < result.length; i++) {
                str += "<div class=\"col-md-3\">\n" +
                    "            <div class=\"card \" style=\"width:200px;height: 400px\">\n" +
                    "                <img class=\"card-img-top\" src=\"travel-images/square-medium/" + result[i].PATH + "\" style=\"width:100%\">\n" +
                    "                <div class=\"card-body\">\n" +
                    "                    <h4 class=\"card-title\">" + result[i].Title + "</h4>\n" +
                    "                    <p>作者："+result[i].Author+"</p>\n" +
                    "                    <p>收藏人数："+result[i].likeperson+"</p>\n" +
                    "                    <a href=\"/detail?id=" + result[i].ImageID + "\" class=\"btn btn-primary\">详情</a>\n" +
                    "                </div>\n" +
                    "            </div>\n" +
                    "        </div>";
            }

            str += "<div class='row'>" +
                "<nav  class='col-md-5 col-md-offset-4' aria-label=\"Page navigation\" >\n" +
                "            <ul class=\"pagination \">\n" +
                "                <li>\n" +
                "                    <a href=\"#\" aria-label=\"Previous\">\n" +
                "                        <span aria-hidden=\"true\">&laquo;</span>\n" +
                "                    </a>\n" +
                "                </li>";

            for (var i = 1; i <= totalPage; i++) {
                if (page === i) {
                    str += "<li class='active'><a>" + i + "</a></li>";
                } else {
                    str += "<li><a href='javascript:showPage("+ i + ");'>" + i + "</a></li>";
                }
            }

            str += " <li>\n" +
                "            <a href=\"#\" aria-label=\"Next\">\n" +
                "                <span aria-hidden=\"true\">&raquo;</span>\n" +
                "            </a>\n" +
                "        </li>\n" +
                "        </ul>\n" +
                "        </nav>" +
                "</div>";
        }
        $('#resultPart').empty().html(str);
    }

    $(document).ready(function () {
        $('#submit').click(function () {
            var text = $('#text').val();
            var type = $("input[name='type']:checked").val();
            var order = $("input[name='order']:checked").val();
            $.ajax({
                type: "post",
                async: false,
                url: '/search',
                data: {"text": text, "type": type, "order": order},
                data_type: 'json',
                timeout: 30000,
                success: function (data) {
                    result = JSON.parse(data).results;
                    if (result!= null ) {
                        totalCount = result.length;
                        totalPage = Math.ceil(totalCount / pageSize);
                    }
                    showPage(1);
                }
            });
        });

    });

</script>

</html>
