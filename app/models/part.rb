class Part < ActiveRecord::Base
  attr_accessible :name, :qty, :comment, :user_id, :branch, :ordered, :po_number, :part_number
  belongs_to :user

  after_create :new_update
  after_update :update_update

  scope :parts_current_branch, lambda{ |branch_number| where('branch = ?', branch_number)  }
  scope :ascending, order("name ASC")

  def new_update
    Updater.new(self, :update_type => :new)
  end

  def new_message
    "#{self.user.name.titleize} added a part to parts list."
  end

  def update_update
    Updater.new(self, update_type: :update)
  end

  def update_message
    "#{self.user.name.titleize} ordered #{self.name}."
  end

  def ordered!
    self.ordered=true
    self.save
  end

end
