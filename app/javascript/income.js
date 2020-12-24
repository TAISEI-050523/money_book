//収入入力の非同期通信
if (location.pathname === "/incomes/new" ) {
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
      if(categoryID.value == 1){ // 「分類」の入力チェック
        errorMessage = "・分類を選択して下さい\n";
      }

      if(price.value == ""){ // 「金額」の入力をチェック
        errorMessage = errorMessage + "・金額を入力して下さい\n";
      }

      if(!price.value.match(/[1-10000000]\d/)){ // 「金額」の入力をチェック
        errorMessage = errorMessage + "・金額は半角数字で 1円以上 10,000,000円以内で入力してください\n";
      }

      if(date.value == ""){ // 「入金日」の入力をチェック
        errorMessage = errorMessage + "・入金日を入力して下さい\n";
      }
      
      if(errorMessage) {
        alert(errorMessage);
        return;
      }

      const XHR = new XMLHttpRequest();
      XHR.open("POST", "/incomes", true);
      XHR.responseType = "json";
      XHR.send(formData);
      XHR.onload = () => {

        if (XHR.status != 200) {
          alert(`Error ${XHR.status}: ${XHR.statusText}`);
          return null;
        };

        const detail = XHR.response.income;
        const categoryName = XHR.response.category;
        const incomeDate = XHR.response.date;
        
        const newDetail= document.getElementById("new-detail");
        const HTML = `
          <div class="detail">
            <div class="category-detail white-color">
              ${categoryName.attributes.name}
            </div>
            <div class="price-detail income-color white-color">
              ${detail.price}円
            </div>
            <div class="date-detail white-color">
              ${incomeDate}
            </div>
            <div class="remarks-detail white-color">
              ${detail.remarks }
            </div>
            <div class="delete-detail white-color new-color">
              New
            </div>
          </div>`;
        newDetail.insertAdjacentHTML("afterend", HTML);
        categoryID.value = 1;
        remarks.value = "";
        price.value = "";
        date.value = "";
      };
      e.preventDefault();
    });
  });
}
