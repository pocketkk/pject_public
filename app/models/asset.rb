class Asset < ActiveRecord::Base
  attr_accessible :name, :serial, :workorder_id, :chemicals_attributes, 
                  :options_attributes, :status, :ready, :assetnotes_attributes,
                  :water_plumbing,:drain_plumbing,:electrical_option, :asset_photos_attributes
                  
  belongs_to :workorder
  has_many :chemicals
  has_many :options
  has_many :assetnotes
  has_many :asset_photos
  
  accepts_nested_attributes_for :chemicals, :allow_destroy => true
  accepts_nested_attributes_for :options, :allow_destroy => true
  accepts_nested_attributes_for :assetnotes, :allow_destroy => true
  accepts_nested_attributes_for :asset_photos, :allow_destroy => true
  
  scope :serial_nil, where(:serial => nil)
  scope :serial_blank, where(:serial => "")
  
  validates :name, presence: true
  
end
