class Video < ActiveRecord::Base
  attr_accessible :description, :is_complete, :title, :yt_video_id, :tag_list
  acts_as_taggable

  belongs_to :user
  has_many :comments, as: :commentable

  scope :completes, where(:is_complete => true)
  scope :incompletes, where(:is_complete => false)

  scope :recently_added, limit(10).order("created_at DESC")

  def self.yt_session
    @yt_session ||= YouTubeIt::Client.new(:username => YouTubeITConfig.username , :password => YouTubeITConfig.password , :dev_key => YouTubeITConfig.dev_key)
  end

  def self.delete_video(video)
    yt_session.video_delete(video.yt_video_id)
    video.destroy
  rescue
    video.destroy
  end

  def self.update_video(video, params)
    yt_session.video_update(video.yt_video_id, video_options(params))
    video.update_attributes(params)
  end

  def self.token_form(params, nexturl)
    yt_session.upload_token(video_options(params), nexturl)
  end

  def self.delete_incomplete_videos
    self.incompletes.map{|r| r.destroy}
  end

  private
    def self.video_options(params)
      opts = {:title => params[:title],
             :description => params[:description],
             :category => "People",
             :keywords => ["test"]}
      params[:is_unpublished] == "1" ? opts.merge(:private => "true") : opts
    end

end
