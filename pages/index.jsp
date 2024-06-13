<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

<head>
    <!-- 引入外部樣式表 -->
    <link rel="stylesheet" href="../assets/css/style.css">
    <!-- 引入外部 JavaScript 文件 -->
    <script src="../assets/JS/script.js"></script>
</head>

<body>
    <!-- 頁面標題及介紹 -->
    <div class="header">
        <h1>Blossom</h1>
        <p>歡迎您來 Blossom，讓我們為您的生活增添一抹花香，一份溫暖，一份浪漫。</p>
    </div>

    <!-- 頁面導航欄 -->
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

    <!-- 幻燈片展示 -->
    <div class="slideshow-container">
        <!-- 幻燈片 1 -->
        <div class="mySlides fade">
            <div class="numbertext">1 / 3</div>
            <a href="goods1.jsp">
                <img src="../assets/images/slidepic_1.PNG" style="width:100%">
            </a>
        </div>
        <!-- 幻燈片 2 -->
        <div class="mySlides fade">
            <div class="numbertext">2 / 3</div>
            <a href="goods2.jsp">
                <img src="../assets/images/slidepic_2.PNG" style="width:100%">
            </a>
        </div>
        <!-- 幻燈片 3 -->
        <div class="mySlides fade">
            <div class="numbertext">3 / 3</div>
            <a href="goods.jsp">
                <img src="../ssets/images/slidepic_3.PNG" style="width:100%">
            </a>
        </div>
    </div>
    <br>

    <!-- 幻燈片下方圓點 -->
    <div style="text-align:center">
        <span class="dot"></span>
        <span class="dot"></span>
        <span class="dot"></span>
    </div>

    <div class="separator"></div>

    <div class="contact-container">
        <!-- 地圖 -->
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3617.2564638182093!2d121.23820147482957!3d24.9573875413732!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3468221447a0f021%3A0x2b86d2650bb8bcff!2z5Lit5Y6f5aSn5a24!5e0!3m2!1szh-TW!2stw!4v1714793727621!5m2!1szh-TW!2stw" width="600" height="500" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>

        <!-- 聯絡表單 -->
        <div class="container">
            <h3>Contact Form</h3>
            <form id="contactForm" action="visitorCounter.jsp" method="post">
                <label for="fname">Member ID</label>
                <input type="text" id="MemberID" name="MemberID" placeholder="Your memberID.." required>

                <label for="lname">Member Name</label>
                <input type="text" id="MemberName" name="MemberName" placeholder="Your name.." required>

                <label for="country">Member Address</label>
                <select id="MemberAddress" name="MemberAddress" required>
                    <option value="tw">Taiwan</option>
                    <option value="australia">Australia</option>
                    <option value="canada">Canada</option>
                    <option value="usa">USA</option>
                </select>

                <label for="subject">Subject</label>
                <textarea id="Subject" name="Subject" placeholder="Write something.." style="height:150px" required></textarea>

                <input type="submit" value="Submit">
            </form>
        </div>
    </div>


    <!-- 頁腳 -->
    <div class="footer">
        <p>版權所有 &copy; 2024 Blossom</p>
        <!-- 訪客計數器 -->
        <%@include file="visitorCounter.jsp" %>
    </div>

    <!-- 回到頂部按鈕 -->
    <button onclick="scrollToTop()" id="scrollToTopBtn" title="Go to top">Top</button>

    <!-- AJAX 处理表单提交 -->
    <script>
        document.getElementById("contactForm").addEventListener("submit", function(event) {
            event.preventDefault(); // 防止表单的默认提交行为

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "visitorCounter.jsp", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                    alert("已收到回覆，謝謝你的支持！");
                    document.getElementById("contactForm").reset(); // 重置表单
                }
            };

            var formData = new FormData(document.getElementById("contactForm"));
            var encodedData = [];
            for (var pair of formData.entries()) {
                encodedData.push(encodeURIComponent(pair[0]) + "=" + encodeURIComponent(pair[1]));
            }

            xhr.send(encodedData.join("&"));
        });
    </script>
</body>

</html>
