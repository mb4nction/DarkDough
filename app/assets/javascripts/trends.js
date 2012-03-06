$(function(){
  var subcategoryFilterLink = function() {
    var links = $('#sub_filter li');

    links.click(function(){
      $(this).siblings().removeClass('active');
      $(this).addClass('active');
      return false;
    });
  },

  toggleCategories = function() {
    var menuLinks = $('#main_filter a'),
        containers = $('.bubble-info');

    menuLinks.click(function(event){
      var resContainer = $("#" + event.target.id + "_container"),
          categoryName = $(this).text();
      containers.removeClass('active');
      resContainer.addClass('active');
      $('#filter_category').text(categoryName);
      $(this).parent().siblings().removeClass('active');
      $(this).parent().addClass('active');
      return false;
    })
  };

  subcategoryFilterLink();
  toggleCategories();
});