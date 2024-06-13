function login() {
    var username = document.getElementById("username").value;
    var password = document.getElementById("password").value;

    // 簡單的帳號密碼驗證
    if (username === "admin" && password === "123456") {
        alert("登入成功！");
        window.location.href = "backstage.html";
    } else {
        alert("帳號或密碼錯誤");
    }
}



