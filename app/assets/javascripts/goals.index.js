//$(function() {
	$('.btn-add').click(function(){
		if($(this).hasClass('off')){
			$('.goal_category_list').fadeOut()
		}else{
			$('.goal_category_list').fadeIn()
		}
		$(this).toggleClass('off');
	});
	
	$('.goals.current > .list > .item').hover(
		function(){
			$(this).toggleClass('over');
		}
	);
	$('.goals.current > .list > .item').click(function(){
		$('.item-add-panel').hide();
		$(this).siblings().removeClass('selected');
		if($(this).hasClass('selected')){
			$(this).removeClass('selected');
			$(this).next().fadeOut();
		}else{
			$(this).addClass('selected');
			$(this).next().fadeIn();
		}
	});
	
	$('.item-add-panel > .wrapper > .next-steps > .list > .item').live('hover', function(){
		$('.over-action', this).toggle();
	});
	
	$('.item-add-panel > .wrapper > .actions > .btn-delete').click(function(){
		if(!confirm('Are you sure?'))return;
		var id = $(this).attr('id');
		var url = g_goals_path + "/" + id;
		$('.loading-overlay').show();
		$.ajax({
			url : url,
			type : 'DELETE',
			cache : false,
			success : function(response){
				if(response=='success') location.reload();
			}
		});
	});

	$('.item-add-panel > .wrapper > .actions > .btn-edit').click(function(){
		var url = $(this).attr('url');
		fn_init_waiter();
		$.ajax({
			url : url,
			cache : false,
			success : function(response){
				fn_clear_waiter();
				$('.overlay').fadeIn(500);
				fn_show_dialog(response);
			}
		});
	});




	$('.overlay').addClass('black').fadeIn(500);
	$('.movitation-filter-dialog').show();
	$('.close-btn, .btn-no').click(function(){
		$('.movitation-filter-dialog').fadeOut();
		$('.overlay').fadeOut();
	});
	$('.btn-yes').click(function(){
		window.open($(this).attr('next_url'), '_self');
	});


	/****************** Goal Detail Section ************************/

	$('.btn-plus').click(function(){
		var form = $(this).parents('form');
		var url = form.attr('action');
		var data = form.serialize();
		fn_init_waiter();
		var _this = this;
		$.ajax({
			type: 'POST',
			url : url,
			cache: false,
			data : data,
			dataType: 'json',
			success: function(response){
				fn_clear_waiter();
				if(response.status){
					form.get(0).reset();
					fn_fetch_goal_details(_this);
				}else{
					alert('An error occured while saving data.');
				}
			}
		});
	});
	
	$('.next-steps .list .item .over-action .delete').live('click', function(){
		if(!confirm("Are you sure to delete this item?"))return;
		var id = $(this).attr('id');
		var url = g_goal_details_path+"/"+id;
		var _this = this;
		$.ajax({
			type: 'DELETE',
			url : url,
			cache: false,
			success: function(response){
				if(response.status){
					fn_fetch_goal_details(_this);
				}else{
					alert('An error occured while deleting data.');
				}
			}
		});
	});
	
	$('.next-steps .list .item .over-action .edit').live('click', function(){
		_btn_edit = this;
		_data_id = $(this).attr('id');
		_this = this;
		var val = $(this).parents('.item').find('span').text();
		$('<div><label>Description: </label><input size=40 value='+val+' /></div>').dialog({
			title: 'Edit',
			width: 330, 
			modal: true,
			resizable: false,
			buttons: {
				"OK": function(){
					var desc = $('input:first', this).val();
					var form = $('form#new_goal_detail', $(_this).parents('.next-steps') );
					$('input#goal_detail_desc', form).val(desc);
					var url = form.attr('action')+"/"+_data_id;
					var data = form.serialize();
					$(this).dialog('close');
					form.get(0).reset();
					fn_init_waiter();
					$.ajax({
						url : url,
						cache: false,
						type: 'PUT',
						dataType: 'json',
						data : data,
						success: function(response){
							fn_clear_waiter();
							
							if(response.status){
								fn_fetch_goal_details(_btn_edit);
							}else{
								alert('An error occured while editing data.');
							}
						}
					});
				},
				"Cancel": function(){
					$(this).dialog('close');
				}
			}
		});
	});
	
	function fn_fetch_goal_details(_btn_add){
		fn_init_waiter();
		var _this = _btn_add;
		var goal_id = $(_this).parents('.next-steps').attr('id');
		var url = g_goal_details_path+"/"+goal_id;
		$.ajax({
			url : url,
			cache: false,
			dataType: 'json',
			success: function(response){
				fn_clear_waiter();
				if(response.status){
					var result = response.result;
					var html = "";
					var k = 0;
					for(k in result){
						var id = result[k].id;
						var desc = result[k].desc;
						first_class = ( (k++==0)?'first':'' );
						html += "<div class='item "+first_class+"'>\
							<input type=checkbox>\
							<span>"+desc+"</span>\
							<div class='over-action'>\
								<div class='button edit' id='"+id+"'>\
									<img src='/assets/icon-edit.png'>\
								</div>\
								<div class='button delete' id='"+id+"'>\
									<img src='/assets/icon-delete.png'>\
								</div>\
							</div>\
						</div>";
					}
				}
				$('.list', $(_this).parents('.next-steps'))
					.empty()
					.html(html);
			}
		});
	}

//});



