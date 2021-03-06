class BeforePhoto < ActiveRecord::Base
  attr_accessible :workorder_id, :photo, :photo_cache
  belongs_to :workorder
  mount_uploader :photo, BeforePhotoUploader
end
