// JavaScript Document
$('.btn-close').click(function(){
	$('.goal-create-dialog').remove();
	$('.overlay').hide();
});

$('.btn-back').click(function(){
	$('.overlay').hide();
	fn_show_dialog(g_goal_preform_dialog_html);
});

var form = $('.goal-create-dialog > form');
var form_id = $('#goal_id', form).val();
if(form_id==""){
	$('.dlg-title').text(g_selected_category_name);
	$('#goal_title').val(g_selected_category_name);
}else{
	var planned_date = $('#goal_planned_date',form).val();
	var date_r = planned_date.split(/[\/|\-]/g);
	$('.btn-back').hide();
	//$('.combowrap.year select', form).val(date_r[0]);
	//$('.combowrap.month select', form).val(date_r[1]);
}

$('.btn-save-goal').click(function(){
	var form = $('.goal-create-dialog > form');
	var goal_form_save_url = form.attr('action');
	var goal_planned_date = 
		$('.combowrap.year select', form).attr('name','').val()+"/"+
		$('.combowrap.month select', form).attr('name','').val()+"/1";

	if($('#goal_category').val()=='')
		$('#goal_category',form).val(g_selected_category_id);
	
	$('#goal_planned_date',form).val(goal_planned_date);

	var data = form.serialize();
	$('.loading-overlay').show();
	$.ajax({
		type: ($('#goal_id', form).val()==""?'POST':'PUT'),
		url: goal_form_save_url,
		cache: false,
		data: data,
		success: function(response){
			$('.loading-overlay').hide();
			if(response.status){
				location.reload();
			}else{
				alert('An error occurred while saving data.');
			}
		}
	});
});

