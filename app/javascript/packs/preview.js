// 不必要なページでjsが発動しないようにする
if (document.URL.match('/goods') ) {                                //newアクションの入力ミス時の対応を考えないと...
  document.addEventListener('DOMContentLoaded', function(){
    // 画像プレビューを表示するHTML要素の抽出
    const imagePreview = document.getElementById("preview");

    // 選択した画像を表示する関数
    const createImageHTML = (blob, imageFile) => {
      // 画像表示のためのHTML要素を生成する
      const imageElement = document.createElement('div');
      const blobImage = document.createElement('img');
      // HTML要素に画像情報を付与させる
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('data-filename', imageFile.name)     // テストコード作成用にファイル名の記録
      blobImage.setAttribute('id', 'image-preview');
      blobImage.setAttribute('width', '300');
      blobImage.setAttribute('height', 'auto');
      // ネスト化（引数が子HTML要素）してブラウザに表示させる
      imageElement.appendChild(blobImage);
      imagePreview.appendChild(imageElement);
    };
    
    // メイン処理
    document.getElementById("item-image").addEventListener('change', function(e){
      // 画像が表示されている場合のみ、すでに存在している画像を削除する
      const imageContent = document.querySelector('#image-preview');
      if (imageContent){
        imageContent.remove();
      }
      // 画像情報を取得し、URLに変換する
      const imageFile = e.target.files[0];
      const blob = window.URL.createObjectURL(imageFile);
      // プレビュー画像表示
      createImageHTML(blob, imageFile);
    });
  });
}