(function($){
  $.fn.customForm = function() {
    var init = function() {
      var container = $('.tabbed'),
          links = $('a.edit', container),
          checkboxes = $('input[type=checkbox]', container),
          selects = $('select', container),
          cancelLinks = $('a.cancel', container),
          checkboxTemplate = _.template("<div class='custom_checkbox'>&nbsp;</div>"),
          forms = $('form', container);

      forms.each(function() {
        $(this).addClass('custom-form')
      });

      selects.each(function() {
        $(this).chosen();
      });

      links.click(function() {
        var linkContainer = $(this).parents('dl');

        $(this).hide();
        linkContainer.toggleClass('active');
        return false;
      });

      checkboxes.each(function() {
        $(this).hide();
        $(this).parent().prepend(checkboxTemplate);
        $(this).parents().find('form').first().addClass()
      });

      var customCheckboxes = $('.custom_checkbox');
      customCheckboxes.each(function() {
        var checkbox = $(this).siblings('input[type=checkbox]');
        if (checkbox.is(':checked')) {
          $(this).toggleClass('active_checkbox')
        }

      });
      customCheckboxes.click(function() {
        var checkbox = $(this).siblings('input[type=checkbox]'),
            form = $(this).parents('form').first();

        checkbox.click();
        $(this).toggleClass('active_checkbox');
        form.submit();
      });

      cancelLinks.click(function() {
        var container = $(this).parents('dl'),
            editLink = $('a.edit', container);

        editLink.show();
        container.toggleClass('active');
        return false;
      });

      forms.each(function() {
        $(this).on('submit', function(){
          $.get(this.action, $(this).serialize(), null, "script");
          return false;
        })
      });
    };

    return init.call(this);
  };
})(jQuery)