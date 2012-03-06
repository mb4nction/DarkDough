$(function(){
  var activeFilterLink = function() {
    var links = $('#graph menu li');

    links.click(function(){
      $(this).siblings().removeClass('active');
      $(this).addClass('active');
      return false;
    });
  };

  activeFilterLink();
});