class Assetnote < ActiveRecord::Base
  attr_accessible :content, :user_id, :asset_id
  belongs_to :asset
  belongs_to :user
end
