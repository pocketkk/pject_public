class Document < ActiveRecord::Base
  attr_accessible :pdfdoc, :description, :pdfdoc_cache
  
  mount_uploader :pdfdoc, PdfdocUploader
  
end
