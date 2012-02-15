$(function() {
  var budgetOptions = function() {
    var inputs = $('.field.radios input'),
        period = $('#budget_period'),
        fakePeriod = $('#period'),
        year = $('#budget_start_1i'),
        month = $('#budget_start_2i'),
        startContainer = $('.start'),
        periodContainer = $('.period')

        currentMonthNumber = (new Date().getMonth() + 1);

    inputs.click(function() {
      if (this.id == 'period_few_month') {
        $('option:eq(' + currentMonthNumber + ')', month).attr('selected', 'selected');
        $('option:first', year).next().attr('selected', 'selected');
        period.val($('option:selected', fakePeriod).val());
        startContainer.show();
        periodContainer.show();
      } else if (this.id == 'period_monthly') {
        $('option:first', month).attr('selected', 'selected');
        $('option:first', year).attr('selected', 'selected');
        period.val('1');
        startContainer.hide();
        periodContainer.hide();
      } else {
        $('option:first', month).attr('selected', 'selected');
        $('option:first', year).attr('selected', 'selected');
        period.val('0');
        startContainer.hide();
        periodContainer.hide();
      }
    });

    fakePeriod.change(function() { period.val($('option:selected', fakePeriod).val()); });

    console.log(period.val());
    if (period.val() == 0) {
      $('#period_once').click();
      period.val(0);
    } else if (period.val() == 1) {
      $('#period_monthly').click();
      period.val(1);
    } else {
      $('#period_few_month').click()
    }
  };

  budgetOptions();
});