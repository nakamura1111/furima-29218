// 不必要なページでjsが発動しないようにする
if (document.URL.match('/goods') ) {                                //newアクションの入力ミス時の対応を考えないと...
  document.addEventListener('DOMContentLoaded', function(){
    // 画像プレビューを表示するHTML要素の抽出
    const imagePreview = document.getElementById("preview");

    // ファイルの入力に対するイベントハンドラ
    const previewEventHandler = (imageElementNum, imageInputBtn) => {
      imageInputBtn.addEventListener('change', (e) => {
        // // 画像が表示されている場合のみ、すでに存在している画像を削除する
        // const imageContent = document.querySelector('#image-preview-new');
        // if (imageContent){
        //   imageContent.remove();
        // }
        // 画像情報を取得し、URLに変換する
        const imageFile = e.target.files[0];
        const blob = window.URL.createObjectURL(imageFile);
        // プレビュー画像表示
        if ( document.getElementById(`item-image-${imageElementNum+1}`) == null ) {
          createImageHTML(blob, imageFile);
        }
        else {
          updateImageHTML(blob, imageFile, imageInputBtn);
        }
      });
    }

    // 選択した画像を表示する関数
    const createImageHTML = (blob, imageFile) => {
      // 画像表示のためのdiv要素を生成する
      const imageElement = document.createElement('div');
      imageElement.setAttribute('id', "image-element-new")
      let imageElementNum = document.querySelectorAll('#image-element-new').length + 1  // div要素の数で現在のプレビュー画像の数を把握する
      
      // 画像表示のためのimg要素を生成する
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('data-filename', imageFile.name)     // テストコード作成用にファイル名の記録
      blobImage.setAttribute('id', 'image-preview-new');
      blobImage.setAttribute('width', '300');
      blobImage.setAttribute('height', 'auto');
      // ネスト化（引数が子HTML要素）してブラウザに表示させる
      imageElement.appendChild(blobImage);
      imagePreview.appendChild(imageElement);
      // ファイル選択数の上限設定(仮)
      if (imageElementNum <= 5 ) {
        // ファイル選択ボタンの生成する
        const imageInputBtn = document.createElement('input')
        imageInputBtn.setAttribute('id', `item-image-${imageElementNum}`)
        imageInputBtn.setAttribute('name', 'good[images][]')
        imageInputBtn.setAttribute('type', 'file')
        // ファイル選択ボタンを表示する
        imageElement.appendChild(imageInputBtn);
        // 新しく生成したファイル選択に対し、プレビューのイベント発火
        previewEventHandler(imageElementNum, imageInputBtn);
      }
    };

    // 選択した画像に変更する関数
    const updateImageHTML = (blob, imageFile, imageInputBtn) => {
      // 画像本体であるimg要素の属性値変更
      const imageElementNum = Number( imageInputBtn.id.match(/[0-9]+/)[0] );                // ファイル選択ボタンのidの末尾についている数値をとりだす。
      const blobImage = document.querySelectorAll('#image-preview-new')[imageElementNum];
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('data-filename', imageFile.name);                        // テストコード作成用にファイル名を記録する。
    };
    
    // メイン処理
    let imageInputBtn = document.getElementById("item-image-0");
    const imageElementNum = 0;
    previewEventHandler(imageElementNum, imageInputBtn);
    // let imageInputBtn = document.getElementById("item-image-0");
    // while(imageInputBtn){
    //   const imageElementNum = Number( imageInputBtn.id.match(/[0-9]+/)[0] );
    //   previewEventHandler(imageElementNum, imageInputBtn);
    //   imageInputBtn = document.getElementById(`item-image-${imageElementNum+1}`);
    // }
  });
}