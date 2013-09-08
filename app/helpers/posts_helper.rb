module PostsHelper

  #truncate and remove formatting for recent posts display
  def truncate_markup(content)
    truncate(content, length: 75).sub(/#*/,"")
  end

end
