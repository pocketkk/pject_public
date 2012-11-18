class VideosController < ApplicationController

  def upload
    @video = Video.create(params[:video])
    if @video
      @upload_info = Video.token_form(params[:video], save_video_new_video_url(:video_id => @video.id))

      @update=current_user.updates.new
      @update.feed_item=current_user.name << " uploaded a video. | " << @video.title.titleize
      @update.save

    else
      respond_to do |format|
        format.html { render "/videos/new" }
      end
    end
  end

  def new
    @video = Video.new
  end

  def edit
    @video=Video.find(params[:id])
  end

  def update
    @video     = Video.find(params[:id])
    @result    = Video.update_video(@video, params[:video])
    respond_to do |format|
      format.html do
        if @result
          redirect_to @video, :notice => "Video successfully updated!"
        else
          respond_to do |format|
            format.html { render "/videos/_edit" }
          end
        end
      end
    end
  end

  def index
    @search = Video.search(params[:q])
    @user_agent=UserAgent.parse(request.user_agent)
    if params[:tag]
      @videos = Video.tagged_with(params[:tag])
      @page_title="Videos by Tag (" << params[:tag].upcase << ")"
    elsif params[:q]
      @videos=@search.result
      @page_title="Videos by Search Result"
    else
      @videos = Video.recently_added
      @page_title = "Recent Videos"
    end
  end

  def show
    @video=Video.find(params[:id])

    @commentable = @video
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def save_video
    @video = Video.find(params[:video_id])
    if params[:status].to_i == 200
      @video.update_attributes(:yt_video_id => params[:id].to_s, :is_complete => true)
      Video.delete_incomplete_videos
    else
      Video.delete_video(@video)
    end
    redirect_to videos_path, :notice => "Video successfully uploaded!"
  end

  def destroy
    @video = Video.find(params[:id])
    if Video.delete_video(@video)
      flash[:notice] = "Video successfully deleted!"

      @update=current_user.updates.new
      @update.feed_item=current_user.name << " removed a video. | " << @video.title.titleize
      @update.save

    else
      flash[:error] = "Video unsuccessfully deleted!"
    end
    redirect_to videos_path
  end

  protected
    def collection
      @videos ||= end_of_association_chain.completes
    end

end
