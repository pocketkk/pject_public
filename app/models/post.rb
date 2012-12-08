class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :tag_list

  acts_as_taggable

  before_save :render_content

  belongs_to :user

  has_many :comments, as: :commentable

  scope :recently_added, limit(5).order("created_at DESC")
  scope :descending, order("created_at DESC")

  validates :content, presence: true
  validates :title, presence: true

  private
    def render_content
        require 'redcarpet'
        renderer = Redcarpet::Render::HTML.new
        extensions = {fenced_code_blocks: true}
        redcarpet = Redcarpet::Markdown.new(renderer, extensions)
        self.rendered_content = redcarpet.render self.content
    end
end
