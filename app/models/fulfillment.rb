class Fulfillment < ActiveRecord::Base
  attr_accessible :machine_id, :workorder_id
  belongs_to :machine
  belongs_to :workorder
end
