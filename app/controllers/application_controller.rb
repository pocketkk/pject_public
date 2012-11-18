class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :yt_client, :comment_update
  def yt_client
    @yt_client ||= YouTubeIt::Client.new(:username => YouTubeITConfig.username , :password => YouTubeITConfig.password , :dev_key => YouTubeITConfig.dev_key)
  end

  def comment_update( commentable_object, commentable_comment )
    @update=current_user.updates.new
        if commentable_object.kind_of?(Workorder)
            @update.feed_item=current_user.name << " commented on " << commentable_object.customer.titleize << "'s workorder.  ( " << commentable_comment << " )"
        end
        if commentable_object.kind_of?(Document)
            @update.feed_item=current_user.name << " commented on " << commentable_object.description.titleize << " document.  ( " << commentable_comment << " )"
        end
        if commentable_object.kind_of?(Video)
            @update.feed_item=current_user.name << " commented on " << commentable_object.title.titleize << " video.  ( " << commentable_comment << " )"
        end
    @update.save
  end


  include SessionsHelper


end
