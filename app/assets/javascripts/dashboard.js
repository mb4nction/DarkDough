// JavaScript Document

//$(function(){
//	$(document).ready(function(){
		$('.my-friends .icon-group .icon').each(function(){
			var data = $(this).attr('data');
			if(!data)return;
			$(this).CreateBubblePopup({
				position : 'top',
				align	 : 'center',
				selectable : true,
				innerHtml: data,
				innerHtmlStyle: {
					color:'#fff',
					'text-align':'left',
					'max-width':'300px'
				},
				themeName : 'all-black',
				themePath: '/bubble/jquerybubblepopup-themes',
				tail : {
					align:'center'
				}
			});
		});
		$('.my-friends').mouseover(function(){
			var n_icons = $('.my-friends .icon-group div[class="icon"]').size();
			if(n_icons<7)return;
			if(!$(this).hasClass('more'))$(this).addClass('more');
			var _w = 240+(n_icons-6)*30;
			_w = (_w>500)?500:_w;
			$(this).width(_w);
			$('.icon-group', this).width(_w);
		});
		$('.my-friends').mouseout(function(e){
			$(this).width('');
			$('.icon-group', this).width('');
			if($(this).hasClass('more'))$(this).removeClass('more');
		});
		
		$('.my-friends .right-more').click(function(){
			if($('.my-friends .icon-group div[class="icon"]:visible').size()<=12)return;
			$('.my-friends .icon-group div[class="icon"]:visible:first').stop().fadeOut();
		});
		
		$('.my-friends .left-more').click(function(){
			$('.my-friends .icon-group div[class="icon"]:hidden:last').stop().fadeIn();
		});
		


		$('.video').mouseover(function(){
			var n_icons = $('.icon-group div.icon', this).size();
			if(n_icons<4)return;
			var _w = 260+(n_icons-2)*115;
			_w = (_w>605)?605:_w;
			$(this).width(_w);
			$('.icon-group', this).width(_w);
			if(!$(this).hasClass('more'))$(this).addClass('more');
		});
		$('.video').mouseout(function(e){
			if($(this).hasClass('more'))$(this).removeClass('more');
			$(this).width('');
			$('.icon-group', this).width('');
		});
		
		$('.video .right-more').click(function(){
			if($('.video .icon-group div.icon:visible').size()<=5)return;
			$('.video .icon-group div.icon:visible:first').stop().fadeOut();
		});
		
		$('.video .left-more').click(function(){
			$('.video .icon-group div.icon:hidden:last').stop().fadeIn();
		});
		
		$('.my-friends .icon.add').click(function(){
			$('.overlay').remove();
			$("<div class='overlay'/>").prependTo('body').fadeIn();
			$('.dialog').show();
			$('.find-friend').hide();
			$('.add-friend').fadeIn();
			$('.add-friend input').val('');
			$('.find-friend input').val('');
		});
		
		$('.add-friend .close-btn, .find-friend .close-btn').click(function(){
			$('.add-friend').hide();
			$('.find-friend').hide();
			$('.overlay').hide();
			$('.dialog').hide();
		});
		
		$('.add-friend .buttons .find').click(function(){
			$('.dialog > div').hide();
			$('.dialog').show();
			$('.find-friend').fadeIn();
			$(window).resize();
		});
		
		$('.find-friend .buttons .invite').click(function(){
			$('.dialog > div').hide();
			$('.dialog').show();
			$('.add-friend').fadeIn();
		});
		
		$('.users .lists ul li a').click(function(){
			var obj = $(this).parents('li');
			var first_name = obj.attr('first_name');
			var last_name = obj.attr('last_name');
			var email = obj.attr('email');
			
			$('.find-friend').fadeOut();
			$('.dialog').show();
			$('.add-friend').fadeIn();
			
			$('.add-friend .inputs .first_name input').val(first_name);
			$('.add-friend .inputs .last_name input').val(last_name);
			$('.add-friend .inputs .email input').val(email);
		});
		
		$('.buttons .send-invite-btn').click(function(){
			;
			alert("The invitation has been sent successfully!");
		});
		
		$('.dashboard .videos .video .icon-group .icon').click(function(){
			$('.overlay').remove();
			$("<div class='overlay'/>").prependTo('body').fadeIn();
			$('.dialog > div').hide();
			$('.dialog').show();
			$('.dialog .video').fadeIn();
		});
		
		$('.dialog .video .actions a:eq(0)').click(function(){
			var s = $('.dialog .video .player').html();
			$('.dialog .video').hide();
			$('.overlay').hide();
			$('.dialog').hide();
		});
		
		$('.dialog .video .actions a:eq(1)').click(function(){
			var s = $('.dialog .video .player').html();
			$('.dialog .video .player').html(s);
			$('.dialog .video').hide();
			$('.overlay').hide();
			$('.dialog').hide();
		});
		
		setTimeout(function(){
			$('.find-friend .users .lists').mCustomScrollbar({
				scrollButtons:{
					enable: false
				}
			});
		},1000);
//	});
//});
