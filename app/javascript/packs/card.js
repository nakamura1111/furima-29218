const pay = () => {
  // 公開鍵の設定
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const form = document.getElementById("charge-form");
  // フォームの送信によるイベント発火
  form.addEventListener("submit", (e) => {
    // フォームをサーバサイドに送る前にトークン生成を行うため、処理のキャンセルを行う
    e.preventDefault();
    // const formResult = document.getElementById("charge-form");
    const formData = new FormData(form);
    // カード情報を変数に入力
    const card = {
      number: formData.get("card_number"),
      cvc: formData.get("cvc"),
      exp_month: formData.get("exp_month"),
      exp_year: `20${formData.get("exp_year")}`
    };
    // Payjpにアクセスし、トークン作成
    Payjp.createToken(card, (status, response) => {
      if ( status == 200 ) {
         // リクエストのフォーム内にトークン入れるためにHTMLに隠し要素として記述
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} type="hidden" name='token'>`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      // パラメータのキーをフォームの要素から削除し、クレジットカード情報をパラメータとして送信するのを防ぐ
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      // サーバーサイドにフォームの送信
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);