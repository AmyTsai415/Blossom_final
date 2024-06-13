<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品評價和評分</title>
	<!-- 引用FontAwesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="../assets/css/review.css">
</head>

<body>
    <%
		request.setCharacterEncoding("UTF-8");
	
        // 確保用戶已登入
        String MemberID = (String) session.getAttribute("MemberID");
        if (MemberID == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 獲取從表單提交的值
        String Star = request.getParameter("Star");
        String Content = request.getParameter("Content");

        // 獲取當前時間作為評論時間
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String MessageTime = formatter.format(new Date());

        // 建立連線
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            // 載入資料庫驅動程式
            Class.forName("com.mysql.jdbc.Driver");

            // 建立連線
            String url = "jdbc:mysql://localhost:3306/shop?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
            con = DriverManager.getConnection(url, "root", "1234");

            if (Star != null && Content != null && !Star.isEmpty() && !Content.isEmpty()) {
                // 執行 SQL 指令
                String sql = "INSERT INTO message (MemberID, ProductID, Content, Star, MessageTime) VALUES (?, '003', ?, ?, ?)";
                pstmt = con.prepareStatement(sql);

                // 設置參數
                pstmt.setString(1, MemberID);
                pstmt.setString(2, Content);
                pstmt.setInt(3, Integer.parseInt(Star));
                pstmt.setString(4, MessageTime);

                // 執行插入操作
                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    
                } else {
                    out.println("新增失敗");
                }
            }
        } catch (Exception e) {
            out.println("連接失敗或SQL錯誤: " + e.toString());
        } finally {
            // 關閉連接和PreparedStatement
            try {
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                out.println("關閉連接失敗: " + ex.toString());
            }
        }
    %>

    <div class="container">
        <h1>商品評價和評分</h1>

        <!-- 評論表單區域 -->
        <div class="review-form">
            <form action="#" method="post" accept-charset="UTF-8">
                <textarea name="Content" placeholder="請輸入您的評論"></textarea>
                
				<div class="star-rating">
                    <input type="radio" name="Star" id="star5" value="5"><label for="star5"></label>
                    <input type="radio" name="Star" id="star4" value="4"><label for="star4"></label>
                    <input type="radio" name="Star" id="star3" value="3"><label for="star3"></label>
                    <input type="radio" name="Star" id="star2" value="2"><label for="star2"></label>
                    <input type="radio" name="Star" id="star1" value="1"><label for="star1"></label>
                </div>
                <input type="submit" value="提交評論">
            </form>
        </div>

        <!-- 評論列表區域 -->
        <div class="review-list">
            <h2>評論列表</h2>
            <ul>
                <%
                    // 重新建立連線，從資料庫中檢索評論
                    Connection con2 = null;
                    PreparedStatement pstmt2 = null;
                    ResultSet rs = null;
                    try {
                        // 建立連線
                        Class.forName("com.mysql.jdbc.Driver");
                        String url = "jdbc:mysql://localhost:3306/shop?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
                        con2 = DriverManager.getConnection(url, "root", "1234");

                        // 查詢評論
                        String query = "SELECT Content, Star FROM message WHERE ProductID = '003' ORDER BY MessageTime DESC";
                        pstmt2 = con2.prepareStatement(query);
                        rs = pstmt2.executeQuery();

                        // 顯示評論
                        while (rs.next()) {
                            String reviewContent = rs.getString("Content");
                            int reviewStar = rs.getInt("Star");
                %>
                <li class="review">
                    <p><%= reviewContent %></p>
                    <p class="rating">評分：<%= reviewStar %></p>
                </li>
                <%
                        }
                    } catch (Exception e) {
                        out.println("檢索評論失敗: " + e.toString());
                    } finally {
                        // 關閉連接和PreparedStatement
                        try {
                            if (rs != null) rs.close();
                            if (pstmt2 != null) pstmt2.close();
                            if (con2 != null) con2.close();
                        } catch (SQLException ex) {
                            out.println("關閉連接失敗: " + ex.toString());
                        }
                    }
                %>
            </ul>
        </div>
    </div>

    <!-- 返回首頁按鈕 -->
    <a href="index.jsp" style="text-align: center; display: block;">
        <input type="submit" value="回首頁" id="button" class="bt">
    </a>

</body>

</html>
