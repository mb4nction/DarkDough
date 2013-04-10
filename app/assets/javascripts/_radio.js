// JavaScript Document
var LOADING_MODE = true;

function fn_validate_radio(){
	var b_break = false;
	var passed = true;
	$('.radio_type').each(function(){
		if(b_break)return;
		if($('button.selected', this).size()==0){
			var obj = $(this).siblings('span');
			obj.addClass('warn');
			$('body').animate({'scrollTop':obj.offset().top-100});
			b_break = true;
			passed = false;
		}
	});
	return passed;
}

//$(function(){
	//, .radio_with_multivalue_type button
	$('.radio_type button').on('click', function(){
		if($(this).hasClass('selected'))return;
		var obj = $(this).parents('div').siblings('span');
				obj.removeClass('warn');
		var form = $(this).parents('form');
		var answer = $(this).attr('id');
		$('#test_answer', form).val(answer);
		$(this)
			.addClass('selected')
			.siblings().removeClass('selected');
	});
//});

