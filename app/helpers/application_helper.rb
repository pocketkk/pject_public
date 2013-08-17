module ApplicationHelper
  # Returns the full page title on a per-page basis.
  def full_title(page_title)
    base_title = "Work Order Machine"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def menu_item(menu_item, delete=false)
    @menu_item = menu_item
    define_path
    content_tag :div, :class => "mobile_icons_wrapper" do
        content_tag(:div, icon(delete), :class => "mobile_icons_top") +
        content_tag(:div, icon_text(delete), :class => "mobile_icons_bottom")
    end
  end

  def icon(delete)
    if delete
        link_to(image_tag("/icons/#{@menu_item}_128.png", :size => "40x40"),
         @icon_path, method: "delete")
    else
        link_to(image_tag("/icons/#{@menu_item}_128.png", :size => "40x40"),
         @icon_path)
    end
  end

  def icon_text(delete)
    if delete
        link_to @menu_item.titleize, @icon_path, method: "delete"
    else
        link_to @menu_item.titleize, @icon_path
    end
  end

  def define_path
    case @menu_item
        when "Home"
            @icon_path=root_path
        when "Calendar"
            @icon_path=calendar_path
        when "Search"
            @icon_path=search_path
        when "Knowledge"
            @icon_path=documents_path
        when "Settings"
            @icon_path=edit_user_path(current_user)
        when "Videos"
            @icon_path=videos_path
        when "Blog"
            @icon_path=posts_path
        when "Bug"
            @icon_path=new_bug_path
        when "Desktop"
            @icon_path=toggle_normal_path
        when "Logout"
            @icon_path=signout_path
        when "New_workorder"
            @icon_path=new_workorder_path
        end
  end

  def label_instructions(text)
    content_tag:div, :class => "label_instructions" do
      text
    end
  end

end
