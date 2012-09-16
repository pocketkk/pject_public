class Update < ActiveRecord::Base
  attr_accessible :feed_item
  belongs_to :user
end
