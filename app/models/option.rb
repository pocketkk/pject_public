class Option < ActiveRecord::Base
  attr_accessible :name, :asset_id
  belongs_to :asset
  EQUIPMENT_OPTIONS = ['Door Bar','Door Start','Quick Start','2 Min Timer','Water Saver','Tall Hood','Leg Extentions']
end
