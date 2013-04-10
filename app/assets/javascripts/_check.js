// JavaScript Document
var LOADING_MODE = true;
//$(function(){
	$('.check_type button').on('click', function(){
		$(this).toggleClass('selected');
		var form = $(this).parents('form');
		var table = $(this).parents('.check_type');
		var s = "";
		$('button.selected', table).each(function(){
			s += ","+$(this).attr('id');
		});
		s = s.substr(1);
		$('#test_answer', form).val(s);
	});
//});

