<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="zh">
<head>
    <!-- 設置文件編碼和頁面縮放 -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 頁面標題 -->
    <title>會員註冊</title>
    <!-- 引入外部樣式表 -->
    <link rel="stylesheet" href="../assets/css/login.css">
    <!-- 引入外部 JavaScript 文件 -->
    <script src="../assets/JS/register.js"></script>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String memberID = request.getParameter("MemberID");
    String password = request.getParameter("Password");
    String confirmPassword = request.getParameter("confirmPassword");
    String memberName = request.getParameter("MemberName");
    String memberPhone = request.getParameter("MemberPhone");
    String memberAddress = request.getParameter("MemberAddress");
    String memberEmail = request.getParameter("MemberEmail");
    String memberBirthday = request.getParameter("MemberBirthday");

    if (memberID != null && password != null && confirmPassword != null && memberName != null &&
        memberPhone != null && memberAddress != null && memberEmail != null && memberBirthday != null) {

        if (!password.equals(confirmPassword)) {
            out.println("<script>alert('抱歉，您的密碼兩次輸入不同');</script>");
        } else {
            try {
                // Step 1: 載入資料庫驅動程式
                Class.forName("com.mysql.cj.jdbc.Driver");
                try {
                    // Step 2: 建立連線
                    String url = "jdbc:mysql://localhost:3306/shop?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Taipei";
                    Connection con = DriverManager.getConnection(url, "root", "1234");
                    if (con.isClosed()) {
                        out.println("<script>alert('連線建立失敗');</script>");
                    } else {
                        // Step 3: 檢查帳號是否已存在
                        String checkSql = "SELECT * FROM member WHERE MemberID = ?";
                        PreparedStatement checkPstmt = con.prepareStatement(checkSql);
                        checkPstmt.setString(1, memberID);
                        ResultSet rs = checkPstmt.executeQuery();
                        if (rs.next()) {
                            // 帳號已存在
                            out.println("<script>alert('此帳號已被註冊');</script>");
                        } else {
                            // Step 4: 執行 SQL 指令
                            String sql = "INSERT INTO member (MemberID, MemberName, MemberPhone, MemberAddress, MemberEmail, Password, MemberBirthday) VALUES (?, ?, ?, ?, ?, ?, ?)";
                            PreparedStatement pstmt = con.prepareStatement(sql);
                            // 設置參數
                            pstmt.setString(1, memberID);
                            pstmt.setString(2, memberName);
                            pstmt.setString(3, memberPhone);
                            pstmt.setString(4, memberAddress);
                            pstmt.setString(5, memberEmail);
                            pstmt.setString(6, password);
                            pstmt.setString(7, memberBirthday);

                            // 執行插入操作
                            int rowsAffected = pstmt.executeUpdate();
                            if (rowsAffected > 0) {
                                out.println("<script>alert('註冊成功！請使用您的帳號和密碼登入。'); window.location.href='login.jsp';</script>");
                            } else {
                                out.println("<script>alert('新增失敗');</script>");
                            }
                            pstmt.close();
                        }
                        rs.close();
                        checkPstmt.close();
                        con.close();
                    }
                } catch (SQLException sExec) {
                    out.println("<script>alert('連接失敗: SQL錯誤" + sExec.toString() + "');</script>");
                }
            } catch (ClassNotFoundException err) {
                out.println("<script>alert('連接失敗: class錯誤" + err.toString() + "');</script>");
            }
        }
    }
%>

<form method="post" accept-charset="UTF-8">
    <!-- 註冊表單容器 -->
    <div class="container">
        <!-- 註冊圖片 -->
        <img src="../assets/images/register.JPG" alt="Avatar" class="avatar">
        <!-- 帳號輸入框 -->
        <input type="text" placeholder="帳號" name="MemberID" id="MemberID" class="input-field" required><br>
        <!-- 密碼輸入框 -->
        <input type="password" placeholder="密碼" name="Password" id="Password" class="input-field" required><br>
        <!-- 確認密碼輸入框 -->
        <input type="password" placeholder="確認密碼" name="confirmPassword" id="confirmPassword" class="input-field" required><br>
        <!-- 會員姓名輸入框 -->
        <input type="text" placeholder="會員姓名" name="MemberName" id="MemberName" class="input-field" required><br>
        <!-- 手機號碼輸入框 -->
        <input type="text" placeholder="手機號碼" name="MemberPhone" id="MemberPhone" class="input-field" required><br>
        <!-- Email輸入框 -->
        <input type="email" placeholder="Email" name="MemberEmail" id="MemberEmail" class="input-field" required><br>
        <!-- 地址輸入框 -->
        <input type="text" placeholder="地址" name="MemberAddress" id="MemberAddress" class="input-field" required><br>
        <!-- 生日輸入框 -->
        <input type="date" placeholder="生日" name="MemberBirthday" id="MemberBirthday" class="input-field" required><br>
        <!-- 註冊按鈕 -->
        <button type="submit" class="input-field">註冊</button>
        <br><a href="login.jsp">已有帳號？點此登入</a>
    </div>
</form>

</body>
</html>
