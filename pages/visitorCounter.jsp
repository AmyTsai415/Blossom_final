<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Blossom首頁</title>
</head>
<body>

<%
    // 初始化計數器
    if (application.getAttribute("counter") == null) {
        application.setAttribute("counter", 1000); // 初始值設定為整數 1000
        out.print("計數器初始值設定為1000<br>");
    }
    
    int counter = (Integer) application.getAttribute("counter"); // 讀取application變數
    
    String clicked = (String) session.getAttribute("clicked"); // 讀取session變數
    if (clicked == null) {
        counter++; // 計數器加1
        session.setAttribute("clicked", "true"); // 設定session變數，標示已點擊
        application.setAttribute("counter", counter); // 更新application變數
    }
%>
<p>訪客數:<%= counter %></p>
<script>
    // 清除 session storage
    sessionStorage.removeItem('clicked');
</script>

<%
    String account = request.getParameter("MemberID");
    String name = request.getParameter("MemberName");
    String city = request.getParameter("MemberAddress");
    String suggestion = request.getParameter("Subject");

    if (account != null && name != null && city != null && suggestion != null) {
        try {
            // Step 1: 載入資料庫驅動程式
            Class.forName("com.mysql.jdbc.Driver");
            try {
                // Step 2: 建立連線
                String url = "jdbc:mysql://localhost/?serverTimezone=UTC";
                Connection con = DriverManager.getConnection(url, "root", "1234");
                if (con.isClosed()) {
                    out.println("連線建立失敗");
                } else {
                    // Step 3: 選擇資料庫
                    con.createStatement().execute("use `shop`");
                    // Step 4: 執行 SQL 指令
                    String sql = "INSERT INTO `contact` (`MemberID`, `MemberName`, `MemberAddress`, `ContactSubject`) VALUES (?, ?, ?, ?)";
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    // 設置參數
                    pstmt.setString(1, account);
                    pstmt.setString(2, name);
                    pstmt.setString(3, city);
                    pstmt.setString(4, suggestion);
                    // 執行插入操作
                    int rowsAffected = pstmt.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("新增成功");
                    } else {
                        out.println("新增失敗");
                    }
                    // 關閉連接和PreparedStatement
                    pstmt.close();
                    con.close();
                }
            } catch (SQLException sExec) {
                out.println("連接失敗: SQL錯誤" + sExec.toString());
            }
        } catch (ClassNotFoundException err) {
            out.println("連接失敗: class錯誤" + err.toString());
        }
    } else {
        
    }
%>
</body>
</html>
