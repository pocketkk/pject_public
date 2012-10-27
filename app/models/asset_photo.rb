class AssetPhoto < ActiveRecord::Base
  attr_accessible :asset_id, :photo, :photo_cache
  belongs_to :asset
  mount_uploader :photo, AfterPhotoUploader
end
