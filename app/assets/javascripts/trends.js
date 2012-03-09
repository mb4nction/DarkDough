$(function(){
  var months = { 1: 'Jan', 2: 'Feb', 3: 'Mar', 4: 'Apr', 5: 'May', 6: 'Jun',
                 7: 'Jul', 8: 'Aug', 9: 'Sep', 10: 'Oct', 11: 'Nov', 12: 'Dec' },
      full_months = { 1: 'January', 2: 'February', 3: 'March', 4: 'April', 5: 'May', 6: 'Jun',
                      7: 'July', 8: 'August', 9: 'September', 10: 'October', 11: 'November', 12: 'December' },
      current_date = new Date(),
      curr_date = current_date.getDate(),
      curr_month = current_date.getMonth(),
      curr_year = current_date.getFullYear();

  $('#timeline').slider({
    range: true,
    min: 0,
    max: 12,
    step: 1,
    values: [current_date.getMonth()-1,current_date.getMonth()],
    animate: true,
    create: function() {
      $('.tl-months').text(full_months[$('#timeline').slider('values', 0) + 1] + " - " + full_months[$('#timeline').slider('values', 1)]);
      $('#trends_start').val(curr_year + "-" + curr_month + "-" + curr_date);
      $('#trends_end').val(curr_year + "-" + curr_month + "-" + curr_date);
    },
    slide: function(event, ui) {
      setPeriod(ui);
    }
  });

  $('#trends_search').submit(function(){
    $.get(this.action, $(this).serialize(), null, "script");
    return false;
  });

  var setPeriod = function(ui) {
    var currentMonth = ui.values[0] + 1;
    $('.tl-months').text(full_months[ui.values[0] + 1] + ' - ' + full_months[ui.values[1]]);
    $('#trends_start').val(curr_year + "-" + currentMonth + "-" + curr_date);
    $('#trends_end').val(curr_year + "-" + ui.values[1] + "-" + curr_date);
    $('#trends_search').submit();
  },

  subcategoryFilterLink = function() {
    var links = $('#sub_filter li');

    links.click(function(){
      $(this).siblings().removeClass('active');
      $(this).addClass('active');
      return false;
    });
  },

  toggleCategories = function() {
    var menuLinks = $('#main_filter a');

    menuLinks.on('click',(function(event) {
      var containers = $('.bubble-info');
      var resContainer = $("." + event.target.id + "_container"),
          categoryName = $(this).text();
      containers.removeClass('active');
      resContainer.addClass('active');
      $('#filter_category').text(categoryName);
      $(this).parent().siblings().removeClass('active');
      $(this).parent().addClass('active');
      return false;
    }))
  };

  subcategoryFilterLink();
  toggleCategories();
});