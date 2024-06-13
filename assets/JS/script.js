// 當頁面完全載入時執行
window.addEventListener("load", (event) => {
  console.log("頁面完全加載");

  let slideIndex = 0;
  showSlides();

  // 函式：顯示輪播圖片
  function showSlides() {
    let i;
    let slides = document.getElementsByClassName("mySlides");
    let dots = document.getElementsByClassName("dot");
    // 隱藏所有幻燈片
    for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";  
    }
    // 自增幻燈片索引
    slideIndex++;
    // 如果索引超出範圍，將其重設為1
    if (slideIndex > slides.length) {slideIndex = 1}    
    // 將所有圓點的類別中的 "active" 替換為空字符串
    for (i = 0; i < dots.length; i++) {
      dots[i].classList.remove("active");
    }
    // 顯示當前幻燈片，並將其相應的圓點設置為 "active"
    slides[slideIndex-1].style.display = "block";  
    dots[slideIndex-1].classList.add("active");
    // 設置定時器，每2秒切換幻燈片
    setTimeout(showSlides, 2000); 
  }
});

// 捲動事件：當用戶滾動頁面時觸發
window.onscroll = function() {scrollFunction()};

// 函式：捲動至頁面頂部
function scrollFunction() {
  // 如果滾動高度超過20像素，顯示返回頂部按鈕，否則隱藏它
  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    document.getElementById("scrollToTopBtn").style.display = "block";
  } else {
    document.getElementById("scrollToTopBtn").style.display = "none";
  }
}

// 函式：將頁面捲動至頂部
function scrollToTop() {
  document.body.scrollTop = 0; 
  document.documentElement.scrollTop = 0; 
}

// 登入邏輯處理
function handleLogin(event) {
  event.preventDefault(); // 阻止表單默認提交
  sessionStorage.setItem('isLogin', 'true');
  redirectToPage("backstage");
}

// 檢查登入狀態
function checkLoginStatus() {
  return sessionStorage.getItem('isLogin') === 'true';
}

// 導向到指定頁面
function redirectToPage(pageName) {
  switch (pageName) {
      case "register":
          window.location.href = "register.html"; // 將使用者導向到會員頁面
          break;
      case "shoppingcart":
          window.location.href = "shoppingcart.html"; // 將使用者導向到購物車頁面
          break;
      case "login":
          window.location.href = "login.html"; // 將使用者導向到登入頁面
          break;
      case "backstage":
          window.location.href = "backstage.html"; // 將使用者導向到後台管理頁面
          break;
      default:
          console.log("Unknown page:", pageName);
          break;
  }
}

// 檢查登入狀態並執行相應功能
function checkLogin(functionName) {
  var isLogin = checkLoginStatus();
  console.log("isLogin", isLogin);
  console.log("functionName", functionName);

  if (functionName === 'backstage' || functionName === 'shoppingcart') {
      isLogin ? redirectToPage(functionName) : redirectToPage("login");
  }
}

function showLogoutMessage() {
  alert("登出成功");
}