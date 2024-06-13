<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html lang="zh">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../assets/css/backstage.css">
    <title>我的資料</title>
    <script src="../assets/JS/backstage.js"></script>
    <script>
        function showWelcomeMessage(message) {
            alert(message);
        }
    </script>
</head>

<body>

<%
    // 获取用户ID，确保用户已登录
    String MemberID = (String) session.getAttribute("MemberID");
    if (MemberID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 获取表单提交的数据
    request.setCharacterEncoding("UTF-8");
    String MemberName = request.getParameter("MemberName");
    String MemberEmail = request.getParameter("MemberEmail");
    String Password = request.getParameter("Password");
    String MemberPhone = request.getParameter("MemberPhone");
    String MemberAddress = request.getParameter("MemberAddress");
    String MemberBirthday = request.getParameter("MemberBirthday");

    boolean modified = false;

    if (MemberName != null && MemberEmail != null && Password != null && MemberPhone != null && MemberAddress != null && MemberBirthday != null) {
        // 执行更新数据库的操作
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop?serverTimezone=Asia/Taipei", "root", "1234");
            String sql = "UPDATE member SET MemberName=?, MemberEmail=?, Password=?, MemberPhone=?, MemberAddress=?, MemberBirthday=? WHERE MemberID=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, MemberName);
            pstmt.setString(2, MemberEmail);
            pstmt.setString(3, Password);
            pstmt.setString(4, MemberPhone);
            pstmt.setString(5, MemberAddress);
            pstmt.setString(6, MemberBirthday);
            pstmt.setString(7, MemberID);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                modified = true;
            }
        } catch (ClassNotFoundException e) {
            out.println("資料庫錯誤：未找到數據庫。");
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            out.println(sw.toString());
        } catch (SQLException e) {
            out.println("資料庫錯誤：" + e.getMessage());
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            out.println(sw.toString());
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    out.println("資料庫錯誤：關閉PreparedStatement時出錯。");
                    StringWriter sw = new StringWriter();
                    e.printStackTrace(new PrintWriter(sw));
                    out.println(sw.toString());
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    out.println("資料庫錯誤：關閉數據庫時出錯。");
                    StringWriter sw = new StringWriter();
                    e.printStackTrace(new PrintWriter(sw));
                    out.println(sw.toString());
                }
            }
        }
    }

    String welcomeMessage = (String) session.getAttribute("welcomeMessage");
    if (welcomeMessage != null) {
%>
    <script>
        showWelcomeMessage('<%= welcomeMessage %>');
    </script>
<%
        session.removeAttribute("welcomeMessage");
    }

    // 顯示資料修改狀態
    if (modified) {
        out.println("<script>alert('資料修改成功');</script>");
    }
%>

<div class="tab">
    <button class="tablinks" onmouseover="backstage(event, 'data')">資料變更</button>
    <button class="tablinks" onmouseover="backstage(event, 'record')">消費紀錄</button>
    <button class="tablinks" onmouseover="backstage(event, 'review')">歷史評論</button>
    <button class="tablinks" onclick="goToHomepage()">回首頁</button>
</div>

<div id="data" class="tabcontent">
    <form action="backstage.jsp" method="post" class="form">
        <div class="form_right">
            <img src="../assets/images/IMG_3615.jpg">
            <div class="form_div">
                <label for="username">使用者姓名：</label>
                <input type="text" id="MemberName" name="MemberName" required>
            </div>
            <div class="form_div">
                <label for="email">電子郵件：</label>
                <input type="email" id="MemberEmail" name="MemberEmail" required>
            </div>
            <div class="form_div">
                <label for="password">密碼：</label>
                <input type="password" id="Password" name="Password" required>
            </div>
            <div class="form_div">
                <label for="phone">手機號碼：</label>
                <input type="text" id="MemberPhone" name="MemberPhone" maxlength="10" required>
            </div>
            <div class="form_div">
                <label for="address">地址：</label>
                <input type="text" id="MemberAddress" name="MemberAddress" required>
            </div>
            <div class="form_div">
                <label for="birthday">生日：</label>
                <input type="date" id="MemberBirthday" name="MemberBirthday" required>
            </div>
            <div>
                <button type="submit" class="btn btn-success">確認修改</button>
                <button type="button" class="btn btn-secondary" onclick="reloadPage()">取消</button>
            </div>
        </div>
    </form>
</div><div id="record" class="tabcontent">
    <div class="transaction-history">
        <% 
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop?serverTimezone=Asia/Taipei", "root", "1234");
            String sql = "SELECT * FROM `orderdetail` WHERE MemberID=? ORDER BY OrderID";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, MemberID);
            rs = pstmt.executeQuery();

            int currentOrderID = -1;
            double totalOrderPrice = 0;

            while (rs.next()) {
                int orderID = rs.getInt("OrderID");
                Date orderTime = rs.getDate("OrderTime");
                String ProductName = rs.getString("ProductName");
                int OrderQuentity = rs.getInt("OrderQuentity");
                double OrderPrice = rs.getDouble("OrderPrice");

                if (orderID != currentOrderID) {
                    if (currentOrderID != -1) {
        %>
                        <div class="transaction-total">
                            <div class="transaction-amount"><p>總金額: $<%= String.format("%.2f", totalOrderPrice) %></p></div>
                        </div>
                    </div> <!-- End transaction-details -->
                    </div> <!-- End transaction-item -->
                    <br> <!-- 插入分隔線 -->
        <% 
                    }
                    currentOrderID = orderID;
                    totalOrderPrice = 0;
        %>
                    <div class="transaction-item">
                        <p>訂單編號: #<%= orderID %></p>
                        <div class="transaction-date"><%= orderTime %></div>
                        <div class="transaction-details">
        <% 
                }

                double itemTotalPrice = OrderQuentity * OrderPrice;
                totalOrderPrice += itemTotalPrice;
        %>
                    <div class="transaction-description">
                        <p>產品: <%= ProductName %></p>
                        <p>數量: <%= OrderQuentity %></p>
                        <p>單價: $<%= String.format("%.2f", OrderPrice) %></p>
                    </div>
        <% 
            }

            // 最後一個訂單的結束標記
            if (currentOrderID != -1) {
        %>
                <div class="transaction-total">
                    <div class="transaction-amount"><p>總金額: $<%= String.format("%.2f", totalOrderPrice) %></p></div>
                </div>
            </div> <!-- End transaction-details -->
            </div> <!-- End transaction-item -->
            <br> <!-- 插入分隔線 -->
        <% 
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.println("資料庫錯誤：" + e.getMessage());
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    out.println("資料庫錯誤：" + e.getMessage());
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    out.println("資料庫錯誤：" + e.getMessage());
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    out.println("資料庫錯誤：" + e.getMessage());
                }
            }
        }
        %>
    </div>
</div>


<div id="review" class="tabcontent">
    <div class="review-history">
        <%
        // 查詢評論資料
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop?serverTimezone=Asia/Taipei", "root", "1234");
            String sql = "SELECT * FROM message WHERE MemberID=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, MemberID);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int MessageID = rs.getInt("MessageID");
                String ProductID = rs.getString("ProductID");
                String Content = rs.getString("Content");
                int Star = rs.getInt("Star");
                Date MessageTime = rs.getDate("MessageTime");
        %>
        
        <div class="review-item">
            <div class="review-details">
                <div class="review-title">評論編號: #<%= MessageID %></div>
                <p>產品: <%= ProductID %></p>
                <p>評分: <%= Star %> / 5</p>
                <p>評論: <%= Content %></p>
            </div>
            <div class="review-date"><%= new SimpleDateFormat("yyyy-MM-dd").format(MessageTime) %></div>
        </div>
        <%
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.println("資料庫錯誤：" + e.getMessage());
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    out.println("資料庫錯誤：" + e.getMessage());
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    out.println("資料庫錯誤：" + e.getMessage());
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    out.println("資料庫錯誤：" + e.getMessage());
                }
            }
        }
        %>
    </div>
</div>

<script>
    function goToHomepage() {
        window.location.href = 'index.jsp';
    }

    function reloadPage() {
        window.location.reload();
    }
</script>

<div class="tabcontent">
    <h3><a href="index.jsp">回首頁</a></h3>
</div>
<div class="clearfix"></div>
</body>
</html>
