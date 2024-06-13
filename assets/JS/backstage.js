// 切換後台功能，顯示特定詳細內容
function backstage(evt, detailName) {
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  // 隱藏所有標籤內容
  for (i = 0; i < tabcontent.length; i++) {
      tabcontent[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablinks");
  // 移除所有標籤按鈕的活動狀態
  for (i = 0; i < tablinks.length; i++) {
      tablinks[i].className = tablinks[i].className.replace(" active", "");
  }
  // 顯示特定的詳細內容
  document.getElementById(detailName).style.display = "block";
  // 將點擊的標籤按鈕設置為活動狀態
  evt.currentTarget.className += " active";
}

// 轉到首頁功能
function goToHomepage() {
  window.location.href = "../index.html"; // 導航到首頁
  console.log("點擊了回首頁"); // 輸出日誌
}

// 重新載入頁面功能
function reloadPage() {
  location.reload(); // 重新載入當前頁面
}
