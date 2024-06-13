// 當用戶滾動頁面時觸發
window.onscroll = function() {
    scrollFunction();
};

// 檢查滾動位置，顯示或隱藏回到頂部按鈕和返回首頁按鈕
function scrollFunction() {
    // 檢查滾動位置，顯示或隱藏回到頂部按鈕
    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
        document.getElementById("scrollToTopBtn").style.display = "block";
    } else {
        document.getElementById("scrollToTopBtn").style.display = "none";
    }

    // 檢查是否滾動到頁面底部，顯示或隱藏返回首頁按鈕
    if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
        var goToHomepageBtn = document.getElementById("goToHomepageBtn");
        goToHomepageBtn.style.display = "block";
    } else {
        var goToHomepageBtn = document.getElementById("goToHomepageBtn");
        goToHomepageBtn.style.display = "none";
    }
}

// 滾動到頁面頂部
function scrollToTop() {
    document.body.scrollTop = 0; // For Safari
    document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
}

// 返回首頁
function goToHomepage() {
    window.location.href = "index.html";
}