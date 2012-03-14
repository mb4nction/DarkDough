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

  $('#trends_search').submit(function(){
    $.get(this.action, $(this).serialize(), null, "script");
    return false;
  });

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

  createTimeline = function() {
    var timelineContainer = $('#timeline'),
        template = _.template("<div class='timeline-month <%= month_class %>' id='<%= month_id %>'><%= month %></div>"),
        today = new Date(),
        aMonth = today.getMonth();
        // Global variables
        timelineHashForStart = {};
        timelineHashForEnd = {};
    for (var i=11; i>=0; i--) {
      var new_month_start = today.getMonth() + 1,
          new_month_end = today.getMonth() + 2;


      timelineContainer.prepend(template({
        month_class: months[aMonth],
        month: months[aMonth],
        month_id: (today.getFullYear() + '-' + new_month_start + '-01')
      }));
      timelineHashForStart[i] = (today.getFullYear() + '-' + new_month_start + '-01');
      if (new_month_end == 13) {
        timelineHashForEnd[i] = ((today.getFullYear() + 1) + '-01' + '-01');
      } else {
        timelineHashForEnd[i] = (today.getFullYear() + '-' + new_month_end + '-01');
      }

      aMonth--;
      today.setMonth(today.getMonth() - 1);
      if (aMonth < 0) { aMonth = 11; }
    }
  };

  $('#timeline').slider({
    min: 0,
    max: 12,
    values: [11,12],
    range: true,
    animate: true,
    create: function(event, ui) {
      createTimeline();
      $('.tl-months').text(full_months[curr_month -1]  + " - " + full_months[curr_month -1]);
      $('#trends_start').val(curr_year + "-" + curr_month + "-01");
      $('#trends_end').val(curr_year + "-" + next_month + "-01");
      $('.timeline-month:last').addClass('selected');
    },
    slide: function(event, ui){
      highlightPeriod(ui);
    },
    stop: function(event, ui) {
      setRange(ui);
    }
  });

  var setRange = function(ui) {
    var rangeStart = timelineHashForStart[ui.values[0]],
        rangeEnd = timelineHashForEnd[ui.values[1] - 1],
        startField = $('#trends_start'),
        endField = $('#trends_end');
    startField.val(rangeStart);
    endField.val(rangeEnd);
    $('#trends_search').submit();
  },

  highlightPeriod = function(ui) {
    var elems = $('#timeline div'),
        startElem = timelineHashForStart[ui.values[0]],
        endElem =  timelineHashForStart[ui.values[1] - 1],
        today = new Date(),
        new_month_end = today.getMonth() + 1;

    elems.removeClass('selected');
    $('#' + startElem).addClass('selected');
    $('#' + endElem).addClass('selected');
    if (startElem !== endElem) {
      $('#' + startElem).nextUntil('#' + endElem).addClass('selected');
    }
  };

  subcategoryFilterLink();
  toggleCategories();
});