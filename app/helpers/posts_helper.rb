module PostsHelper

  #truncate and remove formatting for recent posts display
  def truncate_markup(content)
    truncate(content, length: 100).sub(/#*/,"")
  end

end
