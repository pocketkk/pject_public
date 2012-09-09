class Asset < ActiveRecord::Base
  attr_accessible :name, :serial, :workorder_id, :chemicals_attributes, :options_attributes
  belongs_to :workorder
  has_many :chemicals
  has_many :options
  accepts_nested_attributes_for :chemicals, :allow_destroy => true
  accepts_nested_attributes_for :options, :allow_destroy => true
end
