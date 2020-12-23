// 購入予定リスト追加フォーム商品画像プレビュー機能
if (location.pathname === "/purchase_plans" ) {
  document.addEventListener('DOMContentLoaded', function(){
    const ImageList = document.getElementById('image-list');
    const createImageHTML = (blob) => {
      const imageElement = document.createElement('div');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('class', 'preview');
      imageElement.appendChild(blobImage);
      ImageList.appendChild(imageElement);
    };

    document.getElementById('purchase_plan_image').addEventListener('change', function(e){
      // 画像が表示されている場合のみ、すでに存在しているプレビュー画像を削除する
      const imageContent = document.querySelector('.preview');
      if (imageContent){
        imageContent.remove();
      }
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);
    });
  });
}