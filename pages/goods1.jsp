<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="zh">

<head>
    <link rel="stylesheet" href="../assets/css/goods.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>乾燥花束商品介面</title>
</head>

<body>
<%
    request.setCharacterEncoding("UTF-8");
    String MemberID = (String) session.getAttribute("MemberID");
    if (MemberID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String ProductID = request.getParameter("ProductID");
    String CartPrice = request.getParameter("CartPrice");
    String CartQuentity = request.getParameter("CartQuentity");
    String ProductName = request.getParameter("ProductName");
    String ProductImage = request.getParameter("ProductImage");

    if (ProductID != null && CartPrice != null && CartQuentity != null && ProductName != null && ProductImage != null) {
        Connection con = null;
        PreparedStatement insertCartPstmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/shop?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
            con = DriverManager.getConnection(url, "root", "1234");

            con.setAutoCommit(false);

            String insertCartSql = "INSERT INTO cart (MemberID, ProductID, CartQuentity, CartPrice, ProductName, ProductImage) VALUES (?, ?, ?, ?, ?, ?)";
            insertCartPstmt = con.prepareStatement(insertCartSql);
            insertCartPstmt.setString(1, MemberID);
            insertCartPstmt.setInt(2, Integer.parseInt(ProductID));
            insertCartPstmt.setInt(3, Integer.parseInt(CartQuentity));
            insertCartPstmt.setDouble(4, Double.parseDouble(CartPrice));
            insertCartPstmt.setString(5, ProductName);
            insertCartPstmt.setString(6, ProductImage);
            insertCartPstmt.executeUpdate();

            con.commit();
            response.sendRedirect("shoppingcart.jsp");
            return;
        } catch (Exception e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException se) {
                    out.println("執行失敗: " + se.toString());
                }
            }
            out.println("連接失敗或SQL錯誤: " + e.toString());
        } finally {
            try {
                if (insertCartPstmt != null) insertCartPstmt.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                out.println("關閉連接失敗: " + ex.toString());
            }
        }
    }
%>

    <div class="header">
        <h1>Blossom</h1>
        <p>歡迎您來 Blossom，讓我們為您的生活增添一抹花香，一份溫暖，一份浪漫。</p>
    </div>

    <div class="topnav">
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
        <a href="index.jsp" style="float:right">回首頁</a>
        <form class="search-form" action="search.jsp" method="get">
            <input type="text" placeholder="尋找商品..." name="search">
            <button type="submit">搜索</button>
        </form>
    </div>

<%
    int currentStock1 = 0;
    int currentStock2 = 0;
    int currentStock3 = 0;

    Connection con = null;
    PreparedStatement pstmt1 = null;
    PreparedStatement pstmt2 = null;
    PreparedStatement pstmt3 = null;
    ResultSet rs1 = null;
    ResultSet rs2 = null;
    ResultSet rs3 = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/shop?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
        con = DriverManager.getConnection(url, "root", "1234");

        String getStockSql1 = "SELECT StockQuentity FROM product WHERE ProductID = ?";
        pstmt1 = con.prepareStatement(getStockSql1);
        pstmt1.setInt(1, 4);
        rs1 = pstmt1.executeQuery();
        if (rs1.next()) {
            currentStock1 = rs1.getInt("StockQuentity");
        }

        String getStockSql2 = "SELECT StockQuentity FROM product WHERE ProductID = ?";
        pstmt2 = con.prepareStatement(getStockSql2);
        pstmt2.setInt(1, 5);
        rs2 = pstmt2.executeQuery();
        if (rs2.next()) {
            currentStock2 = rs2.getInt("StockQuentity");
        }

        String getStockSql3 = "SELECT StockQuentity FROM product WHERE ProductID = ?";
        pstmt3 = con.prepareStatement(getStockSql3);
        pstmt3.setInt(1, 6);
        rs3 = pstmt3.executeQuery();
        if (rs3.next()) {
            currentStock3 = rs3.getInt("StockQuentity");
        }

    } catch (Exception e) {
        out.println("連接失敗或SQL錯誤: " + e.toString());
    } finally {
        try {
            if (rs1 != null) rs1.close();
            if (pstmt1 != null) pstmt1.close();
            if (rs2 != null) rs2.close();
            if (pstmt2 != null) pstmt2.close();
            if (rs3 != null) rs3.close();
            if (pstmt3 != null) pstmt3.close();
            if (con != null) con.close();
        } catch (SQLException ex) {
            out.println("關閉連接失敗: " + ex.toString());
        }
    }
%>

    <div class="container">
        <div class="row">
            <div class="product">
                <h2>粉紫夢幻之愛</h2>
                <a href="product1.html"><img src="../assets/images/IMG_3531.jpg"></a>
                <p>商品描述: </p>
                <br>散發著令人陶醉的淡淡花香，象徵著浪漫的愛情之夢。</br>
                <p>價格: $490</p>
                <p>庫存數量: <%= currentStock1 %></p>
                <form action="goods1.jsp" method="post">
                    <input type="hidden" name="ProductID" value="4">
                    <input type="hidden" name="CartPrice" value="490">
                    <input type="number" name="CartQuentity" value="1" min="1" max="<%= currentStock1 %>">
                    <input type="hidden" name="ProductName" value="粉紫夢幻之愛">
                    <input type="hidden" name="ProductImage" value="IMG_3531">
                    <input type="submit" value="加入購物車" class="btn">
                </form>
                <a href="flower4.jsp">商品評價</a>
            </div>
            <div class="product">
                <h2>炙熱戀情之花</h2>
                <a href="product2.html"><img src="../assets/images/IMG_3532.jpg"></a>
                <p>商品描述:</p>
                <br>炙熱的戀情氛圍，花朵散發出濃烈的愛情氣息，讓人心馳神往。</br>
                <p>價格: $390</p>
                <p>庫存數量: <%= currentStock2 %></p>
                <form action="goods1.jsp" method="post">
                    <input type="hidden" name="ProductID" value="5">
                    <input type="hidden" name="CartPrice" value="390">
                    <input type="number" name="CartQuentity" value="1" min="1" max="<%= currentStock2 %>">
                    <input type="hidden" name="ProductName" value="炙熱戀情之花">
                    <input type="hidden" name="ProductImage" value="IMG_3532">
                    <input type="submit" value="加入購物車" class="btn">
                </form>
                <a href="flower5.jsp">商品評價</a>
            </div>
            <div class="product">
                <h2>純淨之愛花園</h2>
                <a href="product3.html"><img src="../assets/images/IMG_3533.jpg"></a>
                <p>商品描述:</p>
                <br>結合了純淨和浪漫，如同一個迷人的愛情花園，為你帶來純淨無瑕的愛情寓意。</br>
                <p>價格: $299</p>
                <p>庫存數量: <%= currentStock3 %></p>
                <form action="goods1.jsp" method="post">
                    <input type="hidden" name="ProductID" value="6">
                    <input type="hidden" name="CartPrice" value="299">
                    <input type="number" name="CartQuentity" value="1" min="1" max="<%= currentStock3 %>">
                    <input type="hidden" name="ProductName" value="純淨之愛花園">
                    <input type="hidden" name="ProductImage" value="IMG_3533">
                    <input type="submit" value="加入購物車" class="btn">
                </form>
                <a href="flower6.jsp">商品評價</a>
            </div>
        </div>
    </div>

    <a href="index.jsp">
        <input type="submit" value="回首頁" id="button" class="bt">
    </a>
</body>

</html>
