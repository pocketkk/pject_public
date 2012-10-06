class Bug < ActiveRecord::Base
  attr_accessible :name, :request_type, :fixed, :user_id, :complete
  belongs_to :user
  
  validates :name, presence: true
  validates :request_type, presence: true

  BUG_TYPES = ['Bug','Feature Request','Other']
  
  
end
