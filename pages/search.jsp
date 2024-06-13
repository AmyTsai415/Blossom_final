<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品搜索與購物車</title>
    <link rel="stylesheet" href="../assets/css/goods.css">
</head>
<body>
    <div class="header">
        <h1>Blossom</h1>
        <p>歡迎您來 Blossom，讓我們為您的生活增添一抹花香，一份溫暖，一份浪漫。</p>
    </div>
    <div class="topnav">
        <!-- 商品鏈接 -->
        <a href="goods1.jsp">乾燥花束</a>
        <a href="goods.jsp">鮮花花束</a>
        <a href="goods2.jsp">鐘罩花</a>

        <!-- 判斷用戶是否登錄 -->
        <%
            if (session.getAttribute("loggedIn") != null && (boolean) session.getAttribute("loggedIn")) {
        %>
            <!-- 已登錄狀態 -->
            <a href="logout.jsp" style="float:right">登出</a>
            <a href="backstage.jsp" style="float:right">我的資料</a>
        <%
            } else {
        %>
            <!-- 未登錄狀態 -->
            <a href="login.jsp" style="float:right">登入/註冊</a>
        <%
            }
        %>
        <a href="shoppingcart.jsp" style="float:right">購物車</a>
        <a href="aboutus.jsp" style="float:right">關於我們</a>
        <a href="backlogin.jsp" style="float:right">賣家系統</a>
        <!-- 搜索表單 -->
        <form class="search-form" action="search.jsp" method="get">
            <input type="text" placeholder="尋找商品..." name="search">
            <button type="submit">搜尋</button>
        </form>
    </div>

    <div class="container">
        <%
			request.setCharacterEncoding("UTF-8");
            String searchQuery = request.getParameter("search");

            // 執行搜索邏輯
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/shop?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
                    try (Connection con = DriverManager.getConnection(url, "root", "1234")) {
                        String sql = "SELECT * FROM product WHERE Classification = ? OR Color = ?";
                        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                            pstmt.setString(1, searchQuery);
                            pstmt.setString(2, searchQuery);
                            try (ResultSet rs = pstmt.executeQuery()) {
                                if (!rs.isBeforeFirst()) {
        %>
                                    <p>沒有找到符合條件的商品。</p>
        <%
                                } else {
        %>
                                    <div class="row">
        <%
                                        while (rs.next()) {
                                            String productId = rs.getString("ProductID");
                                            String productName = rs.getString("ProductName");
                                            String productImage = rs.getString("ProductImage");
                                            int productPrice = rs.getInt("ProductPrice");
                                            int stockQuantity = rs.getInt("StockQuentity");
                                            String productMessage = rs.getString("ProductMessage");
        %>
                                            <div class="product">
                                                <img src="../assets/images/<%= productImage %>.jpg">
                                                <p>商品描述:</p>
                                                <p><%= productMessage %></p>
                                                <p>價格: $<%= productPrice %></p>
                                                <p>庫存數量: <%= stockQuantity %></p>
                                                <!-- 加入購物車表單 -->
                                                <form action="search.jsp" method="post">
                                                    <input type="hidden" name="action" value="addToCart">
                                                    <input type="hidden" name="ProductID" value="<%= productId %>">
                                                    <input type="hidden" name="ProductName" value="<%= productName %>">
                                                    <input type="hidden" name="ProductImage" value="<%= productImage %>">
                                                    <input type="hidden" name="ProductPrice" value="<%= productPrice %>">
                                                    <input type="hidden" name="StockQuantity" value="<%= stockQuantity %>">
                                                    <input type="number" name="quantity" value="1" min="1" max="<%= stockQuantity %>" required>
                                                    <input type="submit" value="加入購物車" class="btn">
                                                </form>
                                                <a href="flower1.jsp">商品評價</a>
                                            </div>
        <%
                                        }
        %>
                                    </div>
        <%
                                }
                            }
                        }
                    }
                } catch (Exception e) {
                    out.println("<p>發生錯誤：" + e.getMessage() + "</p>");
                    e.printStackTrace();
                }
            } else {
        %>
                <p>請輸入搜尋關鍵字。</p>
        <%
            }

            // 處理加入購物車邏輯
			request.setCharacterEncoding("UTF-8");
            String action = request.getParameter("action");
            if ("addToCart".equals(action)) {
                String MemberID = (String) session.getAttribute("MemberID");
                if (MemberID == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }

                String ProductID = request.getParameter("ProductID");
                String ProductName = request.getParameter("ProductName");
                String ProductImage = request.getParameter("ProductImage");
                int ProductPrice = Integer.parseInt(request.getParameter("ProductPrice"));
                int Quantity = Integer.parseInt(request.getParameter("quantity"));

                if (ProductID != null && ProductName != null && ProductImage != null && Quantity > 0) {
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        String url = "jdbc:mysql://localhost:3306/shop?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
                        try (Connection con = DriverManager.getConnection(url, "root", "1234")) {
                            // 查詢購物車是否已有該商品
                            String checkCartSql = "SELECT * FROM cart WHERE MemberID = ? AND ProductID = ?";
                            try (PreparedStatement pstmt = con.prepareStatement(checkCartSql)) {
                                pstmt.setString(1, MemberID);
                                pstmt.setString(2, ProductID);
                                try (ResultSet rs = pstmt.executeQuery()) {
                                    if (rs.next()) {
                                        // 購物車已有該商品，更新數量
                                        int newQuantity = rs.getInt("CartQuentity") + Quantity;
                                        String updateCartSql = "UPDATE cart SET CartQuentity = ? WHERE MemberID = ? AND ProductID = ?";
                                        try (PreparedStatement updateStmt = con.prepareStatement(updateCartSql)) {
                                            updateStmt.setInt(1, newQuantity);
                                            updateStmt.setString(2, MemberID);
                                            updateStmt.setString(3, ProductID);
                                            updateStmt.executeUpdate();
                                        }
                                    } else {
                                        // 購物車沒有該商品，插入新紀錄
                                        String insertCartSql = "INSERT INTO cart (MemberID, ProductID, CartQuentity, CartPrice, ProductName, ProductImage) VALUES (?, ?, ?, ?, ?, ?)";
                                        try (PreparedStatement insertStmt = con.prepareStatement(insertCartSql)) {
                                            insertStmt.setString(1, MemberID);
                                            insertStmt.setString(2, ProductID);
                                            insertStmt.setInt(3, Quantity);
                                            insertStmt.setInt(4, ProductPrice);
                                            insertStmt.setString(5, ProductName);
                                            insertStmt.setString(6, ProductImage);
                                            insertStmt.executeUpdate();
                                        }
                                    }
                                }
                            }
                        }
                        response.sendRedirect("shoppingcart.jsp");
                    } catch (Exception e) {
                        out.println("連接失敗或SQL錯誤: " + e.toString());
                    }
                } else {
                    out.println("請提供所有必要的產品信息。");
                }
            }
        %>
		
		
    
   
                </div>
            </div>
        </div>
		
		<!-- 返回首頁按鈕 -->
    <a href="index.jsp" style="text-align: center; display: block;">
        <input type="submit" value="回首頁" id="button" class="bt">
    </a>
    
    </body>
</html>
