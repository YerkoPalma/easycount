$(document).on('ready page:change', function() {
    Waves.displayEffect();
    $(".button-collapse").sideNav();
    $('.modal-trigger').leanModal();
    $('.tooltipped').tooltip({delay: 50});
  });