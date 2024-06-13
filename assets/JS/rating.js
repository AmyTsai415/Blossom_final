document.querySelector('.review-form').addEventListener('submit', function(e) {
    e.preventDefault(); // 防止表單提交刷新頁面

    const review = this.querySelector('textarea').value; // 獲取評論內容
    const rating = this.querySelector('input[name="rating"]:checked').value; // 獲取評分值

    // 創建評論項目
    const reviewItem = document.createElement('li');
    reviewItem.classList.add('review');
    reviewItem.innerHTML = `
        <p>${review}</p>
        <p class="rating">評分：${rating}</p>
    `;

    // 添加到評論列表中
    document.querySelector('.review-list ul').appendChild(reviewItem);

    // 重置表單
    this.reset();
});
