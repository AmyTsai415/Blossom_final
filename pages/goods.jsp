<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="zh">

<head>
    <link rel="stylesheet" href="../assets/css/goods.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>鮮花花束商品介面</title>
</head>

<body>

<%
    request.setCharacterEncoding("UTF-8");
    String MemberID = (String) session.getAttribute("MemberID");
    if (MemberID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 初始化庫存變量
    int currentStock1 = 0;
    int currentStock2 = 0;
    int currentStock3 = 0;

    // 建立數據庫連接和 PreparedStatements
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

        // 獲取商品1的庫存數量
        String getStockSql1 = "SELECT StockQuentity FROM product WHERE ProductID = ?";
        pstmt1 = con.prepareStatement(getStockSql1);
        pstmt1.setInt(1, 1); // 假設ProductID為1
        rs1 = pstmt1.executeQuery();
        if (rs1.next()) {
            currentStock1 = rs1.getInt("StockQuentity");
        }

        // 獲取商品2的庫存數量
        String getStockSql2 = "SELECT StockQuentity FROM product WHERE ProductID = ?";
        pstmt2 = con.prepareStatement(getStockSql2);
        pstmt2.setInt(1, 2); // 假設ProductID為2
        rs2 = pstmt2.executeQuery();
        if (rs2.next()) {
            currentStock2 = rs2.getInt("StockQuentity");
        }

        // 獲取商品3的庫存數量
        String getStockSql3 = "SELECT StockQuentity FROM product WHERE ProductID = ?";
        pstmt3 = con.prepareStatement(getStockSql3);
        pstmt3.setInt(1, 3); // 假設ProductID為3
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

<div class="container">
    <div class="row">
        <div class="product">
            <h2>粉夢鬱金香</h2>
            <img src="../assets/images/IMG_3528.jpg">
            <p>商品描述: </p>
            <br>這些粉色鬱金香如夢如 幻,綻放著溫柔的浪漫 氛圍。</br>
            <p>價格: $299</p>
            <p>庫存數量: <%= currentStock1 %></p>
            <form action="goods1.jsp" method="post">
                <input type="hidden" name="ProductID" value="001">
                <input type="hidden" name="CartPrice" value="299">
                <input type="number" name="CartQuentity" value="1" min="1" max="<%= currentStock1 %>">
                <input type="hidden" name="ProductName" value="粉夢鬱金香">
                <input type="hidden" name="ProductImage" value="IMG_3528">
                <input type="submit" value="加入購物車" class="btn">
            </form>
            <a href="flower1.jsp">商品評價</a>
        </div>
        <div class="product">
            <h2>純愛之白</h2>
            <img src="../assets/images/IMG_3529.jpg">
            <p>商品描述:</p>
            <br>象徵著純潔和無私的愛 情,為你帶來一束永恆 的愛的寓意。</br>
            <p>價格: $790</p>
            <p>庫存數量: <%= currentStock2 %></p>
            <form action="goods1.jsp" method="post">
                <input type="hidden" name="ProductID" value="002">
                <input type="hidden" name="CartPrice" value="790">
                <input type="number" name="CartQuentity" value="1" min="1" max="<%= currentStock2 %>">
                <input type="hidden" name="ProductName" value="純愛之白">
                <input type="hidden" name="ProductImage" value="IMG_3529">
                <input type="submit" value="加入購物車" class="btn">
            </form>
            <a href="flower2.jsp">商品評價</a>
        </div>
        <div class="product">
            <h2>粉色柔情玫瑰</h2>
            <img src="../assets/images/IMG_3530.jpg">
            <p>商品描述:</p>
            <br>色澤柔和,花瓣如絲般 柔軟,帶給你溫暖和甜 蜜的感受。</br>
            <p>價格: $590</p>
            <p>庫存數量: <%= currentStock3 %></p>
            <form action="goods1.jsp" method="post">
                <input type="hidden" name="ProductID" value="003">
                <input type="hidden" name="CartPrice" value="590">
                <input type="number" name="CartQuentity" value="1" min="1" max="<%= currentStock3 %>">
                <input type="hidden" name="ProductName" value="粉色柔情玫瑰">
                <input type="hidden" name="Product">
                <input type="hidden" name="ProductImage" value="IMG_3530">
                <input type="submit" value="加入購物車" class="btn">
            </form>
            <a href="flower3.jsp">商品評價</a>
        </div>
    </div>
</div>



<a href="index.jsp">
    <input type="submit" value="回首頁" id="button" class="bt">
</a>
</body>

</html>
