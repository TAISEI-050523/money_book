//ログイン時かつ画面横幅400px以下のときハンバーガーメニューを適用
if (!(location.pathname === "/users/sign_in") && !(location.pathname === "/users/sign_up")) {
  window.addEventListener('load', function() {
    const open = document.getElementById('open');
    const overlay = document.querySelector('.overlay');
    const close = document.getElementById('close');

    open.addEventListener('click', () => {
      overlay.classList.add('show');
      open.classList.add('hide');
    });

    close.addEventListener('click', () => {
      overlay.classList.remove('show');
      open.classList.remove('hide');
    });
  });
}