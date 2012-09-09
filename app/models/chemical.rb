class Chemical < ActiveRecord::Base
  attr_accessible :name, :quantity, :asset_id
  belongs_to :asset
end
