class Workorder < ActiveRecord::Base
  attr_accessible :customer
  belongs_to :user
 
  validates :user_id, presence: true
 

end
