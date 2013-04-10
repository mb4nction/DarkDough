// JavaScript Document

var r_proceed_forms = [];

function fn_submit_recursive(){
	if(r_proceed_forms.length==0){
		if(LOADING_MODE)fn_clear_waiter();
		window.open(g_hardfacts_path,"_self");
		return;
	}
	var form = r_proceed_forms.pop();
	var url = form.attr('action');
	var _form = form;
	if(LOADING_MODE)fn_init_waiter();
	$.ajax({
		type: "POST",
		url: url,
		data: form.serialize(),
		success: function(data)
		{
			_form.attr('submitted','yes');
			fn_submit_recursive();
		}
	});
}

function fn_get_checked_item_count(){
	var total_count = $('.test_options').size();
	var selected_count = 0;
	var base_width = 171;

	
	$('.test_options').each(function(){
		if($(this).hasClass('radio_type')){
			if($('button.selected',this).size()>0)selected_count++;
			return;
		}
		if($(this).hasClass('table_type')){
			if($('button.selected',this).size() == 
				$('div.row',this).size() )selected_count++;
			return;
		}
		if($(this).hasClass('check_type')){
			if($('button.selected',this).size()>0)selected_count++;
			return;
		}
		
		if($(this).hasClass('radio_with_multivalue_type')){
			if($('div.selected',this).size()>0)selected_count++;
			return;
		}
		
		if($(this).hasClass('multiline_text_type')){
			if($('input.added',this).size()>0)selected_count++;
			return;
		}
	});
	
	
	bar_width = parseInt((selected_count / total_count)*171);

	$('#test-legend #small-progress .sprogress-bar').width(bar_width);
	$('#test-legend #small-progress .progress-num').text(selected_count + " of "+total_count);
	
	
	
}


//$(function(){
	$('#btn-proceed').click(function(){
		r_proceed_forms = [];
		if(fn_validate_radio() && fn_validate_table()){
			$('form[submitted=no]').each(function(){
				r_proceed_forms.push($(this));
			});
			fn_submit_recursive();
		}
	});
	
	setInterval(function(){
		fn_get_checked_item_count();
	},1000);
//});

