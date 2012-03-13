$(function(){
  var months = { 0: 'Jan', 1: 'Feb', 2: 'Mar', 3: 'Apr', 4: 'May', 5: 'Jun',
                 6: 'Jul', 7: 'Aug', 8: 'Sep', 9: 'Oct', 10: 'Nov', 11: 'Dec' },
      revert_months = { 'Jan': 0, 'Feb': 1 , 'Mar': 2, 'Apr': 3, 'May': 4, 'Jun': 5,
                 'Jul': 6, 'Aug': 7, 'Sep': 8, 'Oct': 9, 'Nov': 10, 'Dec': 11 },
      full_months = { 0: 'January', 1: 'February', 2: 'March', 3: 'April', 4: 'May', 5: 'Jun',
                      6: 'July', 7: 'August', 8: 'September', 9: 'October', 10: 'November', 11: 'December'},

      current_date = new Date(),
      curr_date = current_date.getDate(),
      curr_month = current_date.getMonth() + 1,
      next_month = curr_month + 1,
      curr_year = current_date.getFullYear();

  var createTimeline = function() {
      var container = $('#timeline'),
          cal = _.template("<div class='timeline-month <%= curs %>'><%= month %></div>"),
          today = new Date(),
          aMonth = today.getMonth(),
          i;
          timelineHash = {};

      for (i=11; i>=0; i--) {
        container.prepend(cal({ month: months[aMonth], curs: months[aMonth] }));
        timelineHash[i] = revert_months[months[aMonth]];
        aMonth--;
        if (aMonth < 0) { aMonth = 11; }
      }
    };

  $('#timeline').slider({
    range: true,
    min: 0,
    max: 12,
    step: 1,
    values: [11, 12],
    animate: true,
    create: function() {
      createTimeline();
      $('.tl-months').text(full_months[curr_month -1]  + " - " + full_months[curr_month -1]);
      $('#trends_start').val(curr_year + "-" + curr_month + "-01");
      $('#trends_end').val(curr_year + "-" + next_month + "-01");
      $('.timeline-month:last').addClass('selected');
    },
    stop: function(event, ui) { setPeriod(ui); },
    slide: function(event, ui) { highlightSelectedPeriod(ui); }
  });

  $('#trends_search').submit(function(){
    $.get(this.action, $(this).serialize(), null, "script");
    return false;
  });

  var setPeriod = function(ui) {
    var first_selected = timelineHash[ui.values[0] + 1],
        last_selected = timelineHash[ui.values[1] + 1];

    if (timelineHash[ui.values[0] + 1] == 0) { var first_selected = 12 };
    if (ui.values[0] + 1 == 12) { var first_selected = 3 };
    if (timelineHash[ui.values[1] + 1] == 0) { var last_selected = 12 };
    if (ui.values[1] + 1 == 12) { var last_selected = 3 };
    if (ui.values[1] + 1 == 13) { var last_selected = 4 };
    $('.tl-months').text(full_months[first_selected - 1] + ' - ' + full_months[last_selected - 2]);

    $('#trends_start').val(curr_year + "-" + first_selected + "-01");
    $('#trends_end').val(curr_year + "-" + last_selected + "-01");
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
  },

  highlightSelectedPeriod = function(ui) {
    var start = months[timelineHash[ui.values[0]]],
        end = months[timelineHash[ui.values[1]] - 1];

    if ((timelineHash[ui.values[1]]) == 0 ) {
      var end = months[11]
    };

    $('#timeline div').removeClass('selected');
    $('#timeline div.' + start).addClass('selected');
    $('#timeline div.' + end).addClass('selected');
    if (start !== end) {
      $('#timeline div.' + start).nextUntil('#timeline div.' + end).addClass('selected');
    };

  };

  subcategoryFilterLink();
  toggleCategories();
});