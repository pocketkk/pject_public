class Asset < ActiveRecord::Base
  attr_accessible :name, :serial, :workorder_id, :chemicals_attributes, 
                  :options_attributes, :status, :ready, :assetnotes_attributes,
                  :water_plumbing,:drain_plumbing,:electrical_option
  belongs_to :workorder
  has_many :chemicals
  has_many :options
  has_many :assetnotes
  accepts_nested_attributes_for :chemicals, :allow_destroy => true
  accepts_nested_attributes_for :options, :allow_destroy => true
  accepts_nested_attributes_for :assetnotes, :allow_destroy => true
  
  scope :needs_serial, where(:serial => "")
  
  
  validates :name, presence: true
  
end
