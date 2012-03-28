$(function(){
  $('.chosen').chosen();

  $('.add-account').click(function() {
    $('#new-account-dialog').toggleClass('active');
  });

  $('.dialog-cancel').click(function() {
    $('#new-account-dialog').toggleClass('active');
  });

  var availableBanks = $('#banks-list').html().split(',');
  $('#search-input').autocomplete({
    source: availableBanks,
    select: function(event, ui) {
      $('#banks-list-wrapper').addClass('active')
    }
  });

  $('.clear-bank').click(function() {
    var input = $(this).parent().siblings('input');
    input.val('');
    $('#banks-list-wrapper').removeClass('active')
  });
});