function input_price(){
  const price = document.getElementById("item-price");
  // 価格の入力フォームの値を検知が一回になるように設定
  if (price.getAttribute("data-input") != null) {
    return null;
  }
  price.setAttribute("data-input", "true");
  // 価格入力フォームに入力があった場合、
  price.addEventListener('input', profit_calc);
}

function profit_calc(){
  // リクエスト情報の作成
  const price = document.getElementById("item-price");
  const XHR = new XMLHttpRequest();
  XHR.open("GET", `/goods/profit_calc/?price=${price.value}`, true);
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
}

window.addEventListener("load", profit_calc)      // 誤入力時にフォームに値が入っていた場合の初期設定
window.setInterval(input_price, 1000)