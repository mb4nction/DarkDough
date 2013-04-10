// JavaScript Document

$('.overlay').fadeIn();
$('.btn-close').click(function(){
	$('.overlay').hide();
	$('.goal-preform-dialog').remove();
});

$('.btn-next').click(function(){
	$('.goal-preform-dialog').remove();
	fn_show_dialog(g_goal_form_dialog_html);
});


$('.goal-preform-dialog .options .btn-choose').click(function(){
	;
	$(this).siblings().removeClass('selected');
	$(this).addClass('selected');
});

$('.goal-preform-dialog .accounts .list .account button').click(function(){
	$(this).toggleClass('selected');
});

$('.dlg-title').text(g_selected_category_name);