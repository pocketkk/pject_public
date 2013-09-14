class Document < ActiveRecord::Base
  attr_accessible :pdfdoc, :description, :pdfdoc_cache, :tag_list, :emails_attributes

  mount_uploader :pdfdoc, PdfdocUploader
  acts_as_taggable

  has_many :emails
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :emails

  scope :recently_added, limit(10).order("created_at DESC")

  def new_update(user)
    Updater.new(self, user: user, :update_type => :new)
  end

  def new_message
    "A new document (#{description}) has been uploaded."
  end

  def update_update(user)
    Updater.new(self, update_type: :update, user: user)
  end

  def update_message
    "A user emailed #{description} pdf."
  end

end
