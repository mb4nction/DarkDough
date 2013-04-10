// JavaScript Document

function fn_show_dialog(html){
	$('.dialog-pool').remove();
	$("<div class='dialog-pool'/>").appendTo('body');
	$('.dialog-pool').html(html);
	$('.goal-create-dialog').hide().fadeIn();
}

