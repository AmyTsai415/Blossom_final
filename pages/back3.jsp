<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh-Hant">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>瀏覽訂單</title>
    <link rel="stylesheet" href="../assets/css/back.css">
</head>

<body>
    <div class="header">
        <h1>瀏覽訂單</h1>
    </div>

    <div class=nav>
        <ul>
            <li><a href="back1.jsp">上架商品</a></li>
            <li><a href="back2.jsp">下架商品</a></li>
            <li><a href="back3.jsp">瀏覽訂單</a></li>
            <li><a href="backlogout.jsp">登出</a></li>
            <li><a href="back.jsp">回首頁</a></li>
        </ul>
    </div>

    <div class="content">
        <h2>所有訂單</h2>
        <table>
            <thead>
                <tr>
                    <th>訂單ID</th>
                    <th>會員ID</th>
                    <th>商品ID</th>
                    <th>商品數量</th>
                    <th>訂購時間</th>
                </tr>
            </thead>
            <tbody>
            <%
                if (session == null || session.getAttribute("username") == null) {
                    response.sendRedirect("backlogin.jsp");
                    return;
                }

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    // 載入資料庫驅動
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // 建立連接
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop?serverTimezone=Asia/Taipei", "root", "1234");

                    // 創建 SQL 查詢，使用 OrderDetails 視圖
                    String sql = "SELECT * FROM orderdetail";
                    pstmt = conn.prepareStatement(sql);

                    // 執行查詢並處理結果
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        int orderId = rs.getInt("OrderID");
                        String memberId = rs.getString("MemberID");
                        String productId = rs.getString("ProductID");
                        int quentity = rs.getInt("OrderQuentity");
                        Timestamp orderTime = rs.getTimestamp("OrderTime");
            %>
                <tr>
                    <td><%= orderId %></td>
                    <td><%= memberId %></td>
                    <td><%= productId %></td>
                    <td><%= quentity %></td>
                    <td><%= orderTime %></td>
                </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("錯誤: " + e.getMessage());
                    e.printStackTrace();
                } finally {
                    // 釋放資源
                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            %>
            </tbody>
        </table>
    </div>

</body>

</html>
