$(function(){
  $('.user').click(function(){
    $('.user-menu').toggle();
  })

  // tabs on user profile page
  $(".tabs .block:not('.active-tab')").hide();

  $(".profile-nav li").click(function(){
    thisId = $(this).attr("class").split(' ')[0];

    if (!$(this).hasClass('active-tab')) {
      $(".profile-nav li").removeClass('active-tab');
      $(".tabs .block").removeClass('active-tab');
      $(this).toggleClass('active-tab');
      $(".tabs").find('#' + thisId).addClass('active-tab');
    }
  });
});

