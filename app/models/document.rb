class Document < ActiveRecord::Base
  attr_accessible :pdfdoc, :description, :pdfdoc_cache, :tag_list
  
  mount_uploader :pdfdoc, PdfdocUploader
  acts_as_taggable
  
  scope :recently_added, limit(8).order("created_at DESC")
  
end
