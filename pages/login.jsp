<%@ page contentType="text/html" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>會員登入</title>
    <!-- 設定文件編碼和頁面縮放 -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入外部樣式表 -->
    <link rel="stylesheet" href="../assets/css/login.css">
</head>
<body>

<%
    String memberID = request.getParameter("MemberID");
    String password = request.getParameter("Password");
    String errorMessage = null;

    if (memberID != null && password != null) {
        try {
            // Step 1: 載入資料庫驅動程式
            Class.forName("com.mysql.jdbc.Driver");
            try {
                // Step 2: 建立連線
                String url = "jdbc:mysql://localhost/shop?serverTimezone=UTC";
                Connection con = DriverManager.getConnection(url, "root", "1234");
                if (con.isClosed()) {
                    errorMessage = "連線建立失敗";
                } else {
                    // Step 3: 檢查用戶是否存在及密碼是否正確
                    String sql = "SELECT * FROM `member` WHERE `MemberID` = ? AND `Password` = ?";
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, memberID);
                    pstmt.setString(2, password);
                    ResultSet rs = pstmt.executeQuery();
                    if (rs.next()) {
                        // 登入成功
                        session.setAttribute("MemberID", rs.getString("MemberID"));
                        session.setAttribute("MemberName", rs.getString("MemberName"));
                        session.setAttribute("loggedIn", true); // 保存登入狀態
                        session.setAttribute("welcomeMessage", "歡迎 " + rs.getString("MemberName") + " 登入！"); // 保存歡迎訊息
                        response.sendRedirect("backstage.jsp");
                    } else {
                        // 登入失敗
                        errorMessage = "帳號或密碼錯誤";
                    }
                    rs.close();
                    pstmt.close();
                    con.close();
                }
            } catch (SQLException sExec) {
                errorMessage = "連接失敗: SQL錯誤" + sExec.toString();
            }
        } catch (ClassNotFoundException err) {
            errorMessage = "連接失敗: class錯誤" + err.toString();
        }
    }
%>

<% if (errorMessage != null) { %>
    <script>
        alert('<%= errorMessage %>');
    </script>
<% } %>

<div class="container">
    <form action="login.jsp" method="POST">
        <!-- 登入圖片 -->
        <img src="../assets/images/login.JPG" alt="Avatar" class="avatar">
        <!-- 帳號輸入框 -->
        <input type="text" placeholder="帳號" name="MemberID" id="username" class="input-field" required>
        <!-- 密碼輸入框 -->
        <input type="password" placeholder="密碼" name="Password" id="password" class="input-field" required>
        <!-- 登入按鈕 -->
        <button type="submit" class="input-field">登入</button>
        <!-- 註冊選項 -->
        <div class="register-option">
            還沒有帳號？ <a href="register.jsp">註冊</a>
        </div>
    </form>
</div>

</body>
</html>
