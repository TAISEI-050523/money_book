/* ログイン・新規登録・ログアウト ボタン */
window.addEventListener('load', function(){
  const logOutButton= document.getElementById("log-out")
  logOutButton.addEventListener('mouseover', function(){
    logOutButton.setAttribute("style", "background-color:gray;")
  })
  logOutButton.addEventListener('mouseout', function(){
    logOutButton.removeAttribute("style", "background-color:gray;")
  })
})

window.addEventListener('load', function(){
  const logInButton= document.getElementById("log-in")
  logInButton.addEventListener('mouseover', function(){
    logInButton.setAttribute("style", "background-color:gray;")
  })
  logInButton.addEventListener('mouseout', function(){
    logInButton.removeAttribute("style", "background-color:gray;")
  })
})

window.addEventListener('load', function(){
  const SingUpButton= document.getElementById("sign-up")
  SingUpButton.addEventListener('mouseover', function(){
    SingUpButton.setAttribute("style", "background-color:gray;")
  })
  SingUpButton.addEventListener('mouseout', function(){
    SingUpButton.removeAttribute("style", "background-color:gray;")
  })
})

/* ヘッダーリスト */
window.addEventListener('load', function(){
  const homeButton = document.getElementById("home-btn")
  homeButton.addEventListener('mouseover', function(){
    homeButton.setAttribute("style", "background-color:gray;")
  })
  homeButton.addEventListener('mouseout', function(){
    homeButton.removeAttribute("style", "background-color:gray;")
  })
})

window.addEventListener('load', function(){
  const incomeButton = document.getElementById("income-btn")
  incomeButton.addEventListener('mouseover', function(){
    incomeButton.setAttribute("style", "background-color:gray;")
  })
  incomeButton.addEventListener('mouseout', function(){
    incomeButton.removeAttribute("style", "background-color:gray;")
  })
})

window.addEventListener('load', function(){
  const fixedButton = document.getElementById("fixed-btn")
  fixedButton.addEventListener('mouseover', function(){
    fixedButton.setAttribute("style", "background-color:gray;")
  })
  fixedButton.addEventListener('mouseout', function(){
    fixedButton.removeAttribute("style", "background-color:gray;")
  })
})

window.addEventListener('load', function(){
  const variableButton = document.getElementById("variable-btn")
  variableButton.addEventListener('mouseover', function(){
    variableButton.setAttribute("style", "background-color:gray;")
  })
  variableButton.addEventListener('mouseout', function(){
    variableButton.removeAttribute("style", "background-color:gray;")
  })
})

window.addEventListener('load', function(){
  const purchaseButton = document.getElementById("purchase-btn")
  purchaseButton.addEventListener('mouseover', function(){
    purchaseButton.setAttribute("style", "background-color:gray;")
  })
  purchaseButton.addEventListener('mouseout', function(){
    purchaseButton.removeAttribute("style", "background-color:gray;")
  })
})

/* トップページ支出内訳入力ボタン */
window.addEventListener('load', function(){
  const leftInputButton = document.getElementById("left-input-btn")
  leftInputButton.addEventListener('mouseover', function(){
    leftInputButton.setAttribute("style", "background-color:gray;")
  })
  leftInputButton.addEventListener('mouseout', function(){
    leftInputButton.removeAttribute("style", "background-color:gray;")
  })
})

window.addEventListener('load', function(){
  const rightInputButton = document.getElementById("right-input-btn")
  rightInputButton.addEventListener('mouseover', function(){
    rightInputButton.setAttribute("style", "background-color:gray;")
  })
  rightInputButton.addEventListener('mouseout', function(){
    rightInputButton.removeAttribute("style", "background-color:gray;")
  })
})

/* 入力フォームボタン 共通 */
window.addEventListener('load', function(){
  const submitButton = document.getElementById("submit-btn")
  submitButton.addEventListener('mouseover', function(){
    submitButton.setAttribute("style", "background-color:gray;")
  })
  submitButton.addEventListener('mouseout', function(){
    submitButton.removeAttribute("style", "background-color:gray;")
  })
})
