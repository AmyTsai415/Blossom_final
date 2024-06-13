<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>購物車</title>
    <link rel="stylesheet" href="../assets/css/shoppingcart.css">
</head>
<body>
    <header>
        <h1>購物車</h1>
    </header>
    
    <main>
        <div class="cart">
            <div id="cart-items">
                <%
                    Connection con = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    boolean cartIsEmpty = true;
                    double totalAmount = 0.0;
                    String action = request.getParameter("action");
                    String MemberID = (String) session.getAttribute("MemberID"); // 獲取會員ID

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        String url = "jdbc:mysql://localhost:3306/shop?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
                        con = DriverManager.getConnection(url, "root", "1234");

                        // 如果是減少商品數量操作
                        if ("decrease".equals(action)) {
                            String productId = request.getParameter("ProductID");
                            
                            // 更新購物車中商品的數量
                            String sqlUpdate = "UPDATE cart SET CartQuentity = CartQuentity - 1 WHERE ProductID = ? AND MemberID = ? AND CartQuentity > 0";
                            pstmt = con.prepareStatement(sqlUpdate);
                            pstmt.setInt(1, Integer.parseInt(productId));
                            pstmt.setString(2, MemberID);
                            int updatedRows = pstmt.executeUpdate();
                            
                            // 如果更新了購物車中的商品數量
                            if (updatedRows > 0) {
                                // 獲取更新後的商品數量
                                String sqlGetQuantity = "SELECT CartQuentity FROM cart WHERE ProductID = ? AND MemberID = ?";
                                pstmt = con.prepareStatement(sqlGetQuantity);
                                pstmt.setInt(1, Integer.parseInt(productId));
                                pstmt.setString(2, MemberID);
                                rs = pstmt.executeQuery();
                                
                                // 如果商品數量為0，從購物車中刪除該商品
                                if (rs.next() && rs.getInt("CartQuentity") == 0) {
                                    String deleteSql = "DELETE FROM cart WHERE ProductID = ? AND MemberID = ?";
                                    pstmt = con.prepareStatement(deleteSql);
                                    pstmt.setInt(1, Integer.parseInt(productId));
                                    pstmt.setString(2, MemberID);
                                    pstmt.executeUpdate();
                                }
                            }
                            
                            // 重定向到購物車頁面
                            response.sendRedirect("shoppingcart.jsp");
                            return; // 重定向後立即返回，以避免執行下面的代碼
                        }

                        // 如果是確認付款操作
                        if ("checkout".equals(action)) {
                            // 將購物車中的商品插入到orderdetail表中
                            String insertOrderDetailSql = "INSERT INTO orderdetail (MemberID, ProductID, ProductName, ProductImage, OrderQuentity, OrderPrice, TotalPrice, OrderTime) SELECT MemberID, ProductID, ProductName, ProductImage, CartQuentity, CartPrice, (CartQuentity * CartPrice), NOW() FROM cart WHERE MemberID = ?";
                            pstmt = con.prepareStatement(insertOrderDetailSql);
                            pstmt.setString(1, MemberID);
                            pstmt.executeUpdate();

                            // 減少庫存
                            String updateStockSql = "UPDATE product p INNER JOIN cart c ON p.ProductID = c.ProductID SET p.StockQuentity = p.StockQuentity - c.CartQuentity WHERE c.MemberID = ?";
                            pstmt = con.prepareStatement(updateStockSql);
                            pstmt.setString(1, MemberID);
                            pstmt.executeUpdate();

                            // 刪除購物車中的所有商品
                            String deleteCartSql = "DELETE FROM cart WHERE MemberID = ?";
                            pstmt = con.prepareStatement(deleteCartSql);
                            pstmt.setString(1, MemberID);
                            pstmt.executeUpdate();

                            // 跳轉到付款頁面
                            response.sendRedirect("pay.jsp");
                            return;
                        }
						
                        // 獲取購物車内容
                        String sql = "SELECT ProductID, ProductName, ProductImage, SUM(CartQuentity) AS TotalQuantity, SUM(CartPrice * CartQuentity) AS TotalPrice FROM cart WHERE MemberID = ? GROUP BY ProductID, ProductName, ProductImage";
                        pstmt = con.prepareStatement(sql);
                        pstmt.setString(1, MemberID);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            cartIsEmpty = false;
                            totalAmount += rs.getDouble("TotalPrice");
                %>
                <div class="cart-item">
                    <img src="../assets/images/<%= rs.getString("ProductImage") %>.jpg" alt="<%= rs.getString("ProductName") %>">
                    <div class="item-details">
                        <h3><%= rs.getString("ProductName") %></h3>
                        <p>數量: <%= rs.getInt("TotalQuantity") %></p>
                        <p>價格: $<%= rs.getDouble("TotalPrice") %></p>

                        <!-- 減少數量按钮 -->
                        <form action="shoppingcart.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="ProductID" value="<%= rs.getInt("ProductID") %>">
                            <input type="hidden" name="action" value="decrease">
                            <button type="submit" class="decrease-btn">刪除</button>
                        </form>
                    </div>
                    <div class="separator"></div>
                </div>
                <%
                        }
                    } catch (Exception e) {
                        out.println("Error: " + e.toString());
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (con != null) con.close();
                        } catch (SQLException ex) {
                            out.println("Error: " + ex.toString());
                        }
                    }
                %>
                <div class="separator2"></div>
                <div class="total">
                    <h3 style="text-align: right;">總金額:</h3>
                    <p style="text-align: right;">$<%= totalAmount %></p>
                    <form action="shoppingcart.jsp" method="post" style="text-align: right;">
                        <input type="hidden" name="checkoutTotalAmount" value="<%= totalAmount %>">
                        <input type="hidden" name="action" value="checkout">
                        <button type="submit" name="checkout">確認付款</button>
                    </form>
                </div>
                <button type="button" onclick="window.location.href = 'index.jsp';" style="float: left;">回首頁</button>
            </div>
        </div>
    </main>
</body>
</html>
