$(function(){
  var userMenu = function() {
    var links = $('menu.left-side a');

    links.click(function() {
      var linkClass = $(this).attr('class').split(/\s+/)[0],
          container = $('.block.right.' + linkClass),
          containers = $('.block.tabbed');

      links.removeClass('active');
      $(this).addClass('active');
      containers.removeClass('active');
      container.addClass('active');
    })
  };

  userMenu();
});

