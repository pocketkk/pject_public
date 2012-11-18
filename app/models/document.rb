class Document < ActiveRecord::Base
  attr_accessible :pdfdoc, :description, :pdfdoc_cache, :tag_list, :emails_attributes

  mount_uploader :pdfdoc, PdfdocUploader
  acts_as_taggable

  has_many :emails
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :emails

  scope :recently_added, limit(10).order("created_at DESC")

end
