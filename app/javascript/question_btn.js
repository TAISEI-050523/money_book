if (location.pathname === "/" ){
  window.addEventListener('load', function() {
    var dialog = document.getElementById('dialog1');
    var questionBox = document.getElementById('question-btn1');
    var btn_close = document.getElementById('close1');
    questionBox.addEventListener('click', function() {
      dialog.show();
    }, false);
    btn_close.addEventListener('click', function() {
      dialog.close();
    }, false);
  })

  window.addEventListener('load', function() {
    var dialog = document.getElementById('dialog2');
    var questionBox = document.getElementById('question-btn2');
    var btn_close = document.getElementById('close2');
    questionBox.addEventListener('click', function() {
      dialog.show();
    }, false);
    btn_close.addEventListener('click', function() {
      dialog.close();
    }, false);
  })

  window.addEventListener('load', function() {
    var dialog = document.getElementById('dialog3');
    var questionBox = document.getElementById('question-btn3');
    var btn_close = document.getElementById('close3');
    questionBox.addEventListener('click', function() {
      dialog.show();
    }, false);
    btn_close.addEventListener('click', function() {
      dialog.close();
    }, false);
  })

  window.addEventListener('load', function() {
    var dialog = document.getElementById('dialog4');
    var questionBox = document.getElementById('question-btn4');
    var btn_close = document.getElementById('close4');
    questionBox.addEventListener('click', function() {
      dialog.show();
    }, false);
    btn_close.addEventListener('click', function() {
      dialog.close();
    }, false);
  })

  window.addEventListener('load', function() {
    var dialog = document.getElementById('dialog5');
    var questionBox = document.getElementById('question-btn5');
    var btn_close = document.getElementById('close5');
    questionBox.addEventListener('click', function() {
      dialog.show();
    }, false);
    btn_close.addEventListener('click', function() {
      dialog.close();
    }, false);
  })
}