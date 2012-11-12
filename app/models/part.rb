class Part < ActiveRecord::Base
  attr_accessible :name, :qty, :comment, :user_id, :branch, :ordered, :po_number, :part_number
  belongs_to :user
  
  scope :parts_current_branch, lambda{ |branch_number| where('branch = ?', branch_number)  }
  scope :ascending, order("name ASC")
end
