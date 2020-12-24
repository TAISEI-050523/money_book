//収入入力の非同期通信
if (location.pathname === "/fixed_costs/new" ) {
  window.addEventListener('load', function() {
    const submitBtn = document.getElementById("submit-btn");
    submitBtn.addEventListener("click", (e) => {
      const formData = new FormData(document.getElementById("form"));
      const categoryID = document.getElementById("category-id");
      const remarks = document.getElementById("remarks");
      const price = document.getElementById("price");
      const date = document.getElementById("date");
      var errorMessage = "";
      
      // 必須項目(空かどうか)
      if(categoryID.value == 1){ // 「分類」の入力チェック（id=1以外）
        errorMessage = errorMessage　+ "・分類を選択して下さい\n";
      }

      if(price.value == ""){ // 「金額」の空入力をチェック
        errorMessage = errorMessage + "・金額を入力して下さい\n";
      }

      if(!price.value.match(/[1-9]|[1-9][0-9]{1,6}|10000000\d/)){ // 「金額」の半角数字、範囲の入力をチェック
        errorMessage = errorMessage + "・金額は半角数字で 1円以上 10,000,000円以内で入力してください\n";
      }

      if(date.value == ""){ // 「入金日」の入力をチェック
        errorMessage = errorMessage + "・出金日を入力して下さい\n";
      }
      
      if(errorMessage) {
        alert(errorMessage);
        return;
      }

      const XHR = new XMLHttpRequest();
      XHR.open("POST", "/fixed_costs", true);
      XHR.responseType = "json";
      XHR.send(formData);
      XHR.onload = () => {

        if (XHR.status != 200) {
          alert(`Error ${XHR.status}: ${XHR.statusText}`);
          return null;
        };
        
        const detail = XHR.response.fixed_cost;
        const categoryName = XHR.response.category;
        const fixedCostPrice = XHR.response.price;
        const fixedCostDate = XHR.response.date;
        
        const newDetail= document.getElementById("new-detail");
        const HTML = `
          <div class="detail">
            <div class="category-detail white-color">
              ${categoryName.attributes.name}
            </div>
            <div class="price-detail expense-color white-color">
              ${fixedCostPrice}円
            </div>
            <div class="date-detail white-color">
              ${fixedCostDate}
            </div>
            <div class="remarks-detail white-color">
              ${detail.remarks }
            </div>
            <div class="delete-detail white-color new-color">
              New
            </div>
          </div>`;
        newDetail.insertAdjacentHTML("afterend", HTML);
        // 入力後、各フォームを空欄にする。
        categoryID.value = 1;
        remarks.value = "";
        price.value = "";
        date.value = "";
      };
      e.preventDefault();
    });
  });
}
