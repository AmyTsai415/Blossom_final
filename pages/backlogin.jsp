<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, java.io.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="zh-Hant">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>後台管理系統登入</title>
    <link rel="stylesheet" href="../assets/css/back.css">
</head>

<body>
    <div class="header">
        <h1>後台管理系統登入</h1>
    </div>

    <div class="login-content">
        <%
            String hardcodedUsername = "admin";
            String hardcodedPassword = "123456";
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (username != null && password != null) {
                if (username.equals(hardcodedUsername) && password.equals(hardcodedPassword)) {
                    // 登入成功
                    session.setAttribute("username", username);
                    response.sendRedirect("back.jsp");
                    return; // 確保程式碼在這裡停止執行
                } else {
                    // 登入失敗
                    request.setAttribute("errorMessage", "用戶名或密碼錯誤！");
                }
            }
        %>

        <form action="backlogin.jsp" method="post">
            <div class="box">
                <label for="username">用戶名：</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="box">
                <label for="password">密碼：</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit">登入</button>
        </form>
    </div>
</body>

</html>
