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
    <link rel="stylesheet" href="../assets/css/pay.css">
    <title>付款介面</title>
</head>
<body>
<%
	
	request.setCharacterEncoding("UTF-8");
    // 確保用戶已登錄
    String MemberID = (String) session.getAttribute("MemberID");
    if (MemberID == null) {
        response.sendRedirect("login.jsp");
        return;
    }
	
	 // 獲取當前時間作為評論時間
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String OrderTime = formatter.format(new Date());

    // 獲取表單參數
    String MemberName = request.getParameter("MemberName");
    String CityNumber = request.getParameter("CityNumber");
    String City = request.getParameter("City");
    String MemberAddress = request.getParameter("MemberAddress");
    String MemberPhoneTop = request.getParameter("MemberPhoneTop");
    String MemberPhone = request.getParameter("MemberPhone");

    // 確保所有參數都已提供
    if (MemberName != null && CityNumber != null && City != null && MemberAddress != null && MemberPhoneTop != null && MemberPhone != null) {
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/shop?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
            con = DriverManager.getConnection(url, "root", "1234");

            String sql = "INSERT INTO `order` (MemberID, MemberName, CityNumber, City, MemberAddress, MemberPhoneTop, MemberPhone, OrderTime) VALUES (?, ?, ?, ?, ?, ?, ?,  ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, MemberID);
            pstmt.setString(2, MemberName);
            pstmt.setInt(3, Integer.parseInt(CityNumber)); // 確保CityNumber為整數
            pstmt.setString(4, City);
            pstmt.setString(5, MemberAddress);
            pstmt.setString(6, MemberPhoneTop);
            pstmt.setString(7, MemberPhone);
			pstmt.setString(8, OrderTime);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("payment.jsp"); // 跳轉到 payment.jsp 頁面
            } else {
                out.println("<p>訂單提交失敗，請重試。</p>");
            }
        } catch (Exception e) {
            out.println("連接失敗或SQL錯誤: " + e.toString());
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                out.println("關閉連接失敗: " + ex.toString());
            }
        }
    } 
%>

    <!-- 付款介面標題 -->
    <div class="title">
        <h1>付款介面</h1>
    </div>

    <!-- 付款表單容器 -->
    <div class="card">
        <form action="pay.jsp" method="post">
            <!-- 聯絡資訊 -->
            <h3><b>聯絡資訊</b></h3><br>
            <div>
                <!-- 姓名欄位 -->
                <div class="col-md-6">
                    <label for="MemberName">姓名</label>
                    <input type="text" id="MemberName" name="MemberName" placeholder="姓名" required>
                </div>

                <!-- 郵遞區號和城市選擇 -->
                <div class="col-md-6">
                    <label for="CityNumber">郵遞區號</label>
                    <input type="text" id="CityNumber" name="CityNumber" placeholder="郵遞區號" maxlength="3" required>
                    <select id="City" name="City" class="form-select">
                        <option value="">城市</option>
                        <option value="基隆市">基隆市</option>
                        <option value="台北市">台北市</option>
                        <option value="新北市">新北市</option>
                        <option value="桃園市">桃園市</option>
                        <option value="新竹市">新竹市</option>
                        <option value="新竹縣">新竹縣</option>
                        <option value="苗栗縣">苗栗縣</option>
                        <option value="台中市">台中市</option>
                        <option value="彰化縣">彰化縣</option>
                        <option value="南投縣">南投縣</option>
                        <option value="雲林縣">雲林縣</option>
                        <option value="嘉義市">嘉義市</option>
                        <option value="嘉義縣">嘉義縣</option>
                        <option value="台南市">台南市</option>
                        <option value="高雄市">高雄市</option>
                        <option value="屏東縣">屏東縣</option>
                        <option value="台東縣">台東縣</option>
                        <option value="花蓮縣">花蓮縣</option>
                        <option value="宜蘭縣">宜蘭縣</option>
                        <option value="澎湖縣">澎湖縣</option>
                        <option value="金門縣">金門縣</option>
                        <option value="連江縣">連江縣</option>
                    </select>
                </div>

                <!-- 詳細地址欄位 -->
                <div class="col-md-6">
                    <label for="MemberAddress">詳細地址</label>
                    <input type="text" class="form-control" id="MemberAddress" name="MemberAddress" placeholder="詳細地址" required>
                </div>

                <!-- 手機號碼欄位 -->
                <div class="col-md-6">
                    <label for="MemberPhoneTop">手機號碼</label>
                    <select id="MemberPhoneTop" name="MemberPhoneTop" class="form-select">
                        <option value="+886">(台灣)+886</option>
                        <!-- 其他國家的國碼選項 -->
                    </select>
                    <input type="text" id="MemberPhone" name="MemberPhone" placeholder="手機號碼" maxlength="10" required>
                </div>

                <div>
                    <button type="submit" style="float: center;">輸入付款資料</button>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
