$(function(){
  var months = { 1: 'Jan', 2: 'Feb', 3: 'Mar', 4: 'Apr', 5: 'May', 6: 'Jun', 7: 'Jul', 8: 'Aug', 9: 'Sep', 10: 'Oct', 11: 'Nov', 12: 'Dec' };

  $('#timeline').slider({
    range: true,
    min: 0,
    max: 12,
    step: 1,
    values: [6,8],
    animate: true,
    create: function() {
      $('.tl-months').text(months[$('#timeline').slider('values', 0) + 1] + " - " + months[$('#timeline').slider('values', 1)]);
    },
    slide: function(event, ui) {
      setPeriod(ui);
    }
  });

  var setPeriod = function(ui) {
    $('.tl-months').text(months[ui.values[0] + 1] + ' - ' + months[ui.values[1]])};

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
      var resContainer = $("." + event.target.id + "_container"),
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