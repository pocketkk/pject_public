class Machine < ActiveRecord::Base
  attr_accessible :name, :machine_id, :workorder_id
  has_and_belongs_to_many :workorders
  accepts_nested_attributes_for :workorders
  
  def is_new_machine
    self.machines.build
  end
  def is_new_machine(mac)
    self.machines.build(mac)
  end
end
