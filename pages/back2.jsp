<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, java.io.*, javax.servlet.*" %>

<!DOCTYPE html>
<html lang="zh-Hant">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>下架商品</title>
    <link rel="stylesheet" href="../assets/css/back.css">
    <script>
        function setQuantity(productId) {
            let quantity = prompt("請輸入下架數量：", "1");
            if (quantity != null && quantity > 0) {
                document.getElementById("quantity_" + productId).value = quantity;
                document.getElementById("display_quantity_" + productId).textContent = quantity;
            }
        }
    </script>
</head>

<body>
    <%
    // 處理下架商品請求
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String[] productIds = request.getParameterValues("productId");
        if (productIds != null) {
            Connection con = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop?serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=UTF-8", "root", "1234");

                String sql = "UPDATE product SET StockQuentity = StockQuentity - ? WHERE ProductID = ?";
                pstmt = con.prepareStatement(sql);

                for (String productId : productIds) {
                    String quantityStr = request.getParameter("quantity_" + productId);
                    int quantity = Integer.parseInt(quantityStr);
                    pstmt.setInt(1, quantity);
                    pstmt.setString(2, productId);
                    pstmt.executeUpdate();
                }

                out.println("商品上架成功！");
            } catch (Exception e) {
                out.println("錯誤：" + e.getMessage());
                e.printStackTrace();
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                } catch (SQLException se) {
                    out.println("錯誤：" + se.getMessage());
                }
            }
        }
    }
    %>

    <div class="header">
        <h1>下架商品</h1>
    </div>

    <div class="nav">
        <ul>
            <li><a href="back1.jsp">上架商品</a></li>
            <li><a href="back2.jsp">下架商品</a></li>
            <li><a href="back3.jsp">瀏覽訂單</a></li>
            <li><a href="backlogout.jsp">登出</a></li>
            <li><a href="back.jsp">回首頁</a></li>
        </ul>
    </div>

    <div class="content">
        <h2>下架商品</h2>
        <form action="back2.jsp" method="post">
            <table>
                <thead>
                    <tr>
                        <th>選擇</th>
                        <th>商品ID</th>
                        <th>商品名稱</th>
                        <th>商品價格</th>
                        <th>商品庫存</th>
                        <th>商品描述</th>
                        <th>下架數量</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (session == null || session.getAttribute("username") == null) {
                            response.sendRedirect("backlogin.jsp");
                            return;
                        }
                    %>
                    <%
                        Connection con = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop?serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=UTF-8", "root", "1234");
                            String sql = "SELECT * FROM product";
                            pstmt = con.prepareStatement(sql);
                            rs = pstmt.executeQuery();

                            while (rs.next()) {
                                String productId = rs.getString("ProductID");
                                String productName = rs.getString("ProductName");
                                int productPrice = rs.getInt("ProductPrice");
                                int stockQuantity = rs.getInt("StockQuentity");
                                String productMessage = rs.getString("ProductMessage");
                    %>
                    <tr>
                        <td>
                            <input type="checkbox" name="productId" value="<%= productId %>" onclick="setQuantity('<%= productId %>')">
                            <input type="hidden" id="quantity_<%= productId %>" name="quantity_<%= productId %>" value="0">
                        </td>
                        <td><%= productId %></td>
                        <td><%= productName %></td>
                        <td><%= productPrice %></td>
                        <td><%= stockQuantity %></td>
                        <td><%= productMessage %></td>
                        <td><span id="display_quantity_<%= productId %>">0</span></td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("錯誤：" + e.getMessage());
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (pstmt != null) pstmt.close();
                                if (con != null) con.close();
                            } catch (SQLException se) {
                                out.println("錯誤：" + se.getMessage());
                            }
                        }
                    %>
                </tbody>
            </table>
            <button type="submit">確認下架</button>
        </form>
    </div>
</body>

</html>
