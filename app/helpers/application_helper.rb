module ApplicationHelper
  def page_title
    if content_for?(:title)
      "Flicks - #{content_for(:title)}"
    else
      "Flicks"
    end
  end
end
