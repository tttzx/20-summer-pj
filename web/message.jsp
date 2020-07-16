<%--
  Created by IntelliJ IDEA.
  User: surface
  Date: 2020/7/9
  Time: 0:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>信息</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@include file="navbar.jsp" %>
<h2>
<%
    String info = (String) request.getAttribute("info");
    if (info != null) {
        out.print(info+"<br>");
        if (info.equals("Register success!")) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            out.print("name: " + name+"<br>");
            out.print("Email:" + email+"<br>");
        }
    }

%>
</h2>
</body>
</html>
