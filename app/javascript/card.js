const pay = () => {
  const form = document.getElementById('charge-form');
  if (!form) return;
  if (typeof gon === 'undefined') return;

  // PAY.JPテスト公開鍵
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey)

  // 要素を読み込む
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  // 入力フォームを生成して、HTMLの指定したidに埋め込む
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    // トークンを生成
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        // エラーなら何もしない
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        form.insertAdjacentHTML("beforeend", tokenObj);
      }
      // 入力されたカード情報を削除してサーバーへ送信
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      form.submit();
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);