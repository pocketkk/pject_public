module ApplicationHelper
  # Returns the full page title on a per-page basis.
  def full_title(page_title)
    base_title = "Pject.us"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
