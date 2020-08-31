function profit_calc(){
  const input_price = document.getElementById("item-price");
  // 価格の入力フォームの値を検知が一回になるように設定
  if (input_price.getAttribute("data-input") != null) {
    return null;
  }
  input_price.setAttribute("data-input", "true");
  // 価格入力フォームに入力があった場合、
  input_price.addEventListener('input', function(){
    // リクエスト情報の作成
    const XHR = new XMLHttpRequest();
    XHR.open("GET", `/goods/profit_calc/?price=${input_price.value}`, true);
    XHR.responseType = "json";
    XHR.send();
    // レスポンスが帰ってきたら、
    XHR.onload = () => {
      const profit = document.getElementById("profit");
      const item = XHR.response.post;
      const tax = document.getElementById("add-tax-price");
      // 利益と販売手数料の描画
      profit.innerHTML = item.profit;
      tax.innerHTML = item.sales_fee;
    }
  });
}

window.setInterval(profit_calc, 1000)