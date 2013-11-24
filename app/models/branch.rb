class Branch < ActiveRecord::Base

#Class should only be accessed through the assignable module in users.

  belongs_to :user
  attr_accessible :branch_number

end
