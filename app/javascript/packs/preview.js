// 不必要なページでjsが発動しないようにする
if (document.URL.match('/goods') ) {                                //newアクションの入力ミス時の対応を考えないと...
  document.addEventListener('DOMContentLoaded', function(){
    // 画像プレビューを表示するHTML要素の抽出
    const imagePreview = document.getElementById("preview");

    // 選択した画像を表示する関数
    const createImageHTML = (blob, imageFile) => {
      // 画像表示のためのdiv要素を生成する
      const imageElement = document.createElement('div');
      imageElement.setAttribute('id', "image-element")
      let imageElementNum = document.querySelectorAll('#image-element').length  // div要素の数で現在のプレビュー画像の数を把握する
      // 
      // 画像表示のためのimg要素を生成する
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('data-filename', imageFile.name)     // テストコード作成用にファイル名の記録
      blobImage.setAttribute('id', 'image-preview');
      blobImage.setAttribute('width', '300');
      blobImage.setAttribute('height', 'auto');
      // ファイル選択ボタンの生成する
      const inputAdditionalImage = document.createElement('input')
      inputAdditionalImage.setAttribute('id', `item-image-${imageElementNum}`)
      inputAdditionalImage.setAttribute('name', 'good[images][]')
      inputAdditionalImage.setAttribute('type', 'file')
      // ネスト化（引数が子HTML要素）してブラウザに表示させる
      imageElement.appendChild(blobImage);
      imageElement.appendChild(inputAdditionalImage);
      imagePreview.appendChild(imageElement);

      // 新しく生成したファイル選択に対し、プレビューのイベント発火
      inputAdditionalImage.addEventListener('change', (e) => {
        // 画像情報を取得し、URLに変換する
        const imageFile = e.target.files[0];
        const blob = window.URL.createObjectURL(imageFile);
        // プレビュー画像表示
        createImageHTML(blob, imageFile);
      });
    };

    // 選択した画像に変更する関数
    const updateImageHTML = (blob, imageFile) => {
      // 画像本体であるimg要素の属性値変更
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('data-filename', imageFile.name)     // テストコード作成用にファイル名の記録

      // 新しく生成したファイル選択に対し、プレビューのイベント発火
      inputAdditionalImage.addEventListener('change', (e) => {
        // 画像情報を取得し、URLに変換する
        const imageFile = e.target.files[0];
        const blob = window.URL.createObjectURL(imageFile);
        // プレビュー画像表示
        createImageHTML(blob, imageFile);
      });
    };
    
    // メイン処理
    document.getElementById("item-image").addEventListener('change', (e) => {
      // // 画像が表示されている場合のみ、すでに存在している画像を削除する
      // const imageContent = document.querySelector('#image-preview');
      // if (imageContent){
      //   imageContent.remove();
      // }
      // 画像情報を取得し、URLに変換する
      const imageFile = e.target.files[0];
      const blob = window.URL.createObjectURL(imageFile);

      // プレビュー画像表示
      createImageHTML(blob, imageFile);
    });
  });
}