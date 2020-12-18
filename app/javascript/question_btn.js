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