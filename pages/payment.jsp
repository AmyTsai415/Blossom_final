<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="zh-Hant">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/css/creditcard.css">
    <title>信用卡付款</title>
    <style>
        .payment-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #eaabe5;
            color: #fff;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .payment-button:hover {
            background-color: #ecd1f1;
        }
    </style>
</head>

<body>
<%
    request.setCharacterEncoding("UTF-8");

    String MemberID = (String) session.getAttribute("MemberID");
    if (MemberID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 獲取表單參數
    String CardNumber = request.getParameter("CardNumber");
    String CardName = request.getParameter("CardName");
    String ExpiryDateInput = request.getParameter("ExpiryDate");
    String CVV = request.getParameter("CVV");

    boolean paymentSuccessful = false;

    if (CardNumber != null && CardName != null && ExpiryDateInput != null && CVV != null) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/shop?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
            con = DriverManager.getConnection(url, "root", "1234");

            // 獲取最新的 OrderID 作為 PayID
            String getOrderIDSql = "SELECT OrderID FROM `order` WHERE MemberID = ? ORDER BY OrderID DESC LIMIT 1";
            pstmt = con.prepareStatement(getOrderIDSql);
            pstmt.setString(1, MemberID);
            rs = pstmt.executeQuery();

            int PayID = -1;
            if (rs.next()) {
                PayID = rs.getInt("OrderID");
            }

            if (PayID != -1) {
                // 檢查 PayID 是否已存在於 payment 表
                String checkPaymentSql = "SELECT COUNT(*) FROM `payment` WHERE PayID = ?";
                pstmt = con.prepareStatement(checkPaymentSql);
                pstmt.setInt(1, PayID);
                rs = pstmt.executeQuery();
                rs.next();
                int count = rs.getInt(1);

                if (count == 0) {
                    // 插入付款信息到 payment 表
                    String insertPaymentSql = "INSERT INTO `payment` (PayID, CardNumber, CardName, ExpiryDate, CVV) VALUES (?, ?, ?, ?, ?)";
                    pstmt = con.prepareStatement(insertPaymentSql);
                    pstmt.setInt(1, PayID);
                    pstmt.setString(2, CardNumber);
                    pstmt.setString(3, CardName);
                    pstmt.setString(4, ExpiryDateInput);
                    pstmt.setString(5, CVV);

                    int rowsAffected = pstmt.executeUpdate();
                    if (rowsAffected > 0) {
                        // 更新 orderdetail 表，將 OrderID 為空的記錄更新為最新的 OrderID
                        String updateOrderDetailSql = "UPDATE `orderdetail` SET OrderID = ? WHERE OrderID IS NULL";
                        pstmt = con.prepareStatement(updateOrderDetailSql);
                        pstmt.setInt(1, PayID);
                        pstmt.executeUpdate();

                        paymentSuccessful = true;
                    } else {
                        out.println("<p>訂單提交失敗，請重試。</p>");
                    }
                } else {
                    out.println("<p>付款記錄已存在，請重試。</p>");
                }
            } else {
                out.println("<p>未找到對應的訂單，請重試。</p>");
            }
        } catch (Exception e) {
            out.println("連接失敗或SQL錯誤: " + e.toString());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                out.println("關閉連接失敗: " + ex.toString());
            }
        }
    }

    if (paymentSuccessful) {
        out.println("<script>alert('已成功付款! 謝謝您的購買。'); window.location.href='backstage.jsp';</script>");
    }
%>

    <div class="container">
        <h1>付款資訊</h1>
        <form action="payment.jsp" method="post">
            <label for="CardNumber">信用卡號碼</label>
            <input type="text" id="CardNumber" name="CardNumber" placeholder="輸入信用卡號碼" required>

            <label for="CardName">持卡人姓名</label>
            <input type="text" id="CardName" name="CardName" placeholder="輸入持卡人姓名" required>

            <label for="ExpiryDate">到期日</label>
            <input type="date" id="ExpiryDate" name="ExpiryDate" required>

            <label for="CVV">CVV</label>
            <input type="number" id="CVV" name="CVV" placeholder="輸入信用卡背面的三位數字" required>

            <button type="submit" class="payment-button">確定付款</button>
        </form>
    </div>

</body>

</html>
