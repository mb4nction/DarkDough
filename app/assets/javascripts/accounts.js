$(function(){
  $('.chosen').chosen();

  var formSubmit = function() {
    var searchContainer = $("#accounts_list"),
        form = searchContainer.find("form"),
        links = searchContainer.find("a"),
        searchField = form.find("input[type=text]");

    links.click(function(){
      searchField.val(this.text);
      form.submit();
      return false;
    });
  };

  formSubmit();
});