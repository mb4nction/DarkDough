// JavaScript Document
var slider_flag = true;

//$(function(){
	$('body').click(function(){
		setTimeout(function(){
			$('.error').remove();
		},1000);
	});
	$('button').click(function(){
		if($(this).hasClass("selected")){
			val = $(this).attr('value1');
			if($(this).val()==val)val = "";
			$(this).siblings(".display").val(val);
			$(this).siblings(".display").show();
		}else{
			$(this).siblings(".display").val($(this).val());
			$(this).siblings(".display").hide();
		}
		$(this).toggleClass("selected");
		$(this).siblings(".answer").val($(this).siblings(".display").val());
	});
	
	$('.display').keyup(function(){
		$(this).siblings(".answer").val($(this).val());
		$(this).siblings("button").attr("value1", $(this).val());
	});

	$('form#new_test').submit(function(){
		if(!g_submit_flag)return false;
		g_submit_flag = false;
		var passed = true;
		$('.error', this).remove();
		$("input.answer.required", this).each(function(){
			var v = $.trim($(this).val()); $(this).val(v);
			if(v==""){
				passed = false;
				$(this).after("<div class='error empty'/>")
			}
		});
		$("input.answer[value!='']", this).each(function(){
			var v = $(this).val();
			if($(this).attr('type')!='hidden' && /[^0-9,.]/.test(v)){
				passed = false;
				if($(this).siblings('.error').size()==0){
					$(this).after("<div class='error invalid'/>")
				}
			}
		});
		
		if(passed){
			var form = $('form#new_test');
			var url = form.attr('action');
			fn_init_waiter();
			$.ajax({
				type: "POST",
				url: url,
				data: form.serialize(),
				success: function(data)
				{
					fn_clear_waiter();
					window.open(g_testresult_path, "_self");
				}
			});
		}else{
			$('body').animate({'scrollTop':$('.error:first').offset().top-200});
		}
		return false;
	});
	
	var g_submit_flag = false;
	$('.proceed-btn').on('click', function(){
		g_submit_flag = true;
		$('form#new_test').submit();
	});
	
	
	
	
	$('.slider-bar').each(function(){
		$(this).slider({
			value: parseInt($(this).attr('default_value'))+1,
			min: 1,
			max: 100,
			step: 1,
			slide: function( event, ui ) {
					var id = $(event.target).attr('idd');
					$('#'+id).val(ui.value);
			}
		});
	});
	
	
	$('.slider-bar').mousemove(function(){
		slider_flag = true;
	});
	
	$('.slider-bar a').removeAttr('href');
	
	setInterval(function(){
		if(!slider_flag)return;
		slider_flag = false;
		$('.slider-bar a.ui-slider-handle').each(function(){
			var obj = $(this).parent();
      var val = $('#'+obj.attr('idd')).val();
			val = parseInt(val);
      $(this).css('left',val+"%");
			$('#'+obj.attr('idd')).val(val);
		});
	},10);
  $('.slider-bar a.ui-slider-handle').each(function(){
    var obj = $(this).parent();
    $('#'+obj.attr('idd')).keyup(function(){
			val = parseInt(this.value);
      $(this).parents(".slider").find("a.ui-slider-handle").css('left',val+"%")
      $('#'+obj.attr('idd')).val(val);
    });
  });
  $("input[name^='answer[']").change(function(){
    if ( $(this).attr("id") == '_c__how_old_were_you' || $(this).attr("id") == '_c__at_what_age' ) return; 
    if ( $(this).attr("name") == "answer[_c__grossary_income_tax]" || $(this).attr("name") == "answer[_c__business_income_box]" ) return;
    $(this).val(CommaFormatted(CurrencyFormatted(this.value)));
  });
  $("input[name='answer[_c__grossary_income_tax]']").click(function(){
    grossary_income_tax();
  });
  $("input[name='answer[_c__grossary_salary]']").change(function(){
    grossary_income_tax();
  });
  $("input[name='answer[_c__less_paye]']").change(function(){
    amount = $("input[name='answer[_c__grossary_salary]']").val();
    amount = amount.replace(/,/g,"");
    amount = parseFloat(amount);
    tax = this.value;
    tax = tax.replace(/,/g,"");
    tax = parseFloat(tax);
    remain = amount - tax;
    if ( remain < 0 )remain = 0
    $("input[name='answer[_c__net_salary_wages]']").val(CommaFormatted(CurrencyFormatted(remain.toString())));
  });
  $("input[name='answer[_c__business_income_box]']").click(function(){
    business_income_tax();
  });
  $("input[name='answer[_c__biz_income]']").change(function(){
    business_income_tax();
  });
  $("input[name='answer[_c__less_income_tax]']").change(function(){
    amount = $("input[name='answer[_c__biz_income]']").val();
    amount = amount.replace(/,/g,"");
    amount = parseFloat(amount);
    tax = this.value;
    tax = tax.replace(/,/g,"");
    tax = parseFloat(tax);
    remain = amount - tax;
    if ( remain < 0 )remain = 0
    $("input[name='answer[_c__not_biz_income]']").val(CommaFormatted(CurrencyFormatted(remain.toString())));
  });
//});
$(document).ready(function(){
  grossary_income_tax();
  business_income_tax();
});
/*$("input[name='answer[]']").each(function(index){
    $(this).val(index);
});*/
function grossary_income_tax(){
  $("input[name='answer[_c__net_salary_wages]']").attr("disabled","disabled");
  value = "";
  $("input[name='answer[_c__grossary_income_tax]']").each(function(){
    if ( $(this).attr("checked") == "checked") value = this.value;
  })
  switch(value){
    case "y":
      amount = $("input[name='answer[_c__grossary_salary]']").val();
      amount = amount.replace(/,/g,"");
      amount = parseFloat(amount);
      tax = tax_calulate(amount);
      $("input[name='answer[_c__less_paye]']").attr("disabled","disabled").val(CommaFormatted(CurrencyFormatted(tax.toString())));
      $("input[name='answer[_c__net_salary_wages]']").val(CommaFormatted(CurrencyFormatted((amount-tax).toString())));
    break;
    case "n":
      $("input[name='answer[_c__less_paye]']").attr("disabled", false)
    break;
    case "e":
      $("input[name='answer[_c__less_paye]']").attr("disabled","disabled").val(0);  
      $("input[name='answer[_c__net_salary_wages]']").val($("input[name='answer[_c__grossary_salary]']").val());
    break;
  }  
}
function business_income_tax(){
  $("input[name='answer[_c__not_biz_income]']").attr("disabled","disabled");
  $("input[name='answer[_c__business_income_box]']").each(function(){
    if ( $(this).attr("checked") == "checked") value = this.value;
  })
  switch(value){
    case "y":
      amount = $("input[name='answer[_c__biz_income]']").val();
      amount = amount.replace(/,/g,"");
      amount = parseFloat(amount);
      tax = tax_calulate(amount);
      $("input[name='answer[_c__less_income_tax]']").attr("disabled","disabled").val(CommaFormatted(CurrencyFormatted(tax.toString())));
      $("input[name='answer[_c__not_biz_income]']").val(CommaFormatted(CurrencyFormatted((amount-tax).toString())));
    break;
    case "n":
      $("input[name='answer[_c__less_income_tax]']").attr("disabled", false)
    break;
    case "e":
      $("input[name='answer[_c__less_income_tax]']").attr("disabled","disabled").val(0);  
      $("input[name='answer[_c__not_biz_income]']").val($("input[name='answer[_c__biz_income]']").val());
    break;
  }
}

