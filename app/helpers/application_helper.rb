module ApplicationHelper
  def title
    site_title = "pfm"
    @title.nil? ? "#{site_title}" : "#{@title}"
  end

  def acumen_test_menu(user)
    if !user.acumen_tests.any?
      link_to "Create Acumen Test", new_acumen_test_path
    elsif !user.acumen_tests.last.finished == true
      link_to "Continue Acumen Test", edit_acumen_test_path(user.acumen_tests.last)
    elsif user.acumen_tests.last.finished?
      link_to "Acumen Test Result", acumen_test_path(user.acumen_tests.last)
    end
  end
end
