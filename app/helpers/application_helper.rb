module ApplicationHelper
  def title
    site_title = "pfm"
    @title.nil? ? "#{site_title}" : "#{@title}"
  end
end
