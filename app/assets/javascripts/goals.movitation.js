// JavaScript Document

$( ".image" ).draggable({
	helper: "clone"
});

var g_del_image = '';

$( ".pyramid" ).droppable({
	hoverClass: "ui-state-hover",
	accept: ".image",
	drop: function( event, ui ) {
		var src_obj = ui.draggable[0];
		var background_image_url = $(src_obj).css('background-image');
				background_image_url = background_image_url.replace(/^url\(['"]?/gi,'');
				background_image_url = background_image_url.replace(/['"]?\)/gi,'');

		var step = $(this).attr('step');
		
		if( $('.mov-image', this).size() < $(this).attr('max')*1
			){
			var src_obj_id = $(src_obj).attr('id');
			if($('.movitation-panel #'+src_obj_id).size()==0){
				var img = $( "<img class='mov-image' align='absmiddle' id='"+src_obj_id+"'/>" ).attr('src', background_image_url);
				img.mouseover(function(){
					g_del_image = this;
					$('.btn-delete').css({
						'left': $(this).offset().left+$(this).width()-15,
						'top': $(this).offset().top
					}).show().delay(5000).fadeOut();
				});
				var _this = this;
				
				var form = $('form#new_mfilter');
				
				$('#mfilter_filter_id').val(src_obj_id);
				$('#mfilter_step').val(step);
				
				var url = form.attr('action');
				var data = form.serialize();
				
				fn_init_waiter();
				$.ajax({
					type: 'POST',
					url : url,
					cache: false,
					data : data,
					dataType : 'json',
					success: function(response){
						fn_clear_waiter();
						if(response.status=='success'){
							img.attr('data-id', response.data_id);
							img.appendTo( _this );
							fn_check_pyramids();
						}
					}
				});
			}else{
				alert("The selected one exists already here!");
			}
		}else{
			alert("You can only "+$(this).attr('max')+" goals into this step!");
		}
	}
});

$('.mov-image').mouseover(function(){
	g_del_image = this;
	$('.btn-delete').css({
		'left': $(this).offset().left+$(this).width()-15,
		'top': $(this).offset().top
	}).show().delay(5000).fadeOut();
});

$('.btn-delete').click(function(){
																
	if(g_del_image!=''){
		var id = $(g_del_image).attr('data-id');
		var form = $('form#new_mfilter');
		var url = form.attr('action');
		fn_init_waiter();
		$.ajax({
			type: 'DELETE',
			url : url+"/"+id,
			cache: false,
			success: function(response){
				fn_clear_waiter();
				if(response=='success'){
					$(g_del_image).remove();
					$('.btn-delete').hide();
					$('.icon-loading').hide();
					fn_check_pyramids();
				}
			}
		});
	}
});

function fn_check_pyramids(){
	$('.image-panel').css({'background-image':''});
	$('.pyramid').each(function(){
		var bg_img = $(this).attr('bg_img');
		$('.mov-image', this).each(function(){
			$('#goals_category #'+$(this).attr('id')).parents('.image-panel')
				.css({'background-image':'url(/assets/'+bg_img+'?_=1)'});
		});
	});
}


fn_check_pyramids();



