function register() {
    var username = document.getElementById("username").value; // 獲取用戶名
    var password = document.getElementById("password").value; // 獲取密碼
    var confirmPassword = document.getElementById("confirmPassword").value; // 獲取確認密碼

    if (username === "" || password === "" || confirmPassword === "") {
        alert("請填寫完整信息"); // 提示填寫完整信息
    } else if (password !== confirmPassword) {
        alert("密碼和確認密碼不相符"); // 提示密碼不相符
    } else {
        alert("註冊成功！"); // 提示註冊成功
    }

    window.location.href = 'login.html';  //跳到登入介面(新加上的)
}

