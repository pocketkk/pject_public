class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :tag_list

  acts_as_taggable

  belongs_to :user

  has_many :comments, as: :commentable

  scope :recently_added, limit(5).order("created_at DESC")
  scope :descending, order("created_at DESC")

  validates :content, presence: true
  validates :title, presence: true

end
