<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.*, java.io.*, javax.servlet.*" %>

<!DOCTYPE html>
<html lang="zh-Hant">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>後台管理系統</title>
    <link rel="stylesheet" href="../assets/css/back.css">
</head>

<body>
    <%
        if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("backlogin.jsp");
        return;
        }
    %>


    <div class="header">
        <h1>後台管理系統</h1>
    </div>

    <div class=nav>
        <ul>
            <li><a href="back1.jsp">上架商品</a></li>
            <li><a href="back2.jsp">下架商品</a></li>
            <li><a href="back3.jsp">瀏覽訂單</a></li>
            <li><a href="backlogout.jsp">登出</a></li>
        </ul>
    </div>

    <!-- 後台首頁內容 -->
    <div class="content">
        <h2>歡迎來到後台管理系統</h2>
        <p>請選擇功能進行操作。</p>
    </div>

</body>

</html>
