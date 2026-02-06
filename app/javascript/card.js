const pay = () => {
  // PAY.JPテスト公開鍵（ここは自分のものに書き換えます）
  const payjp = Payjp('pk_test_xxxxxxxxxxxxxxxxx') 

  // 要素を読み込む
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  // 入力フォームを生成して、HTMLの指定したidに埋め込む
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault(); // Railsへの送信を一旦キャンセル！

    // トークンを生成
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        // エラーなら何もしない（またはエラー表示）
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      // 入力されたカード情報を削除してサーバーへ送信
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("turbo:load", pay);