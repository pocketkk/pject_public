require 'chronic'

class Workorder < ActiveRecord::Base
  attr_accessible :customer, :street, :city, :state, :wo_date, 
                  :wo_duration, :chronic_wo_date, :phonenumber, :raw_phonenumber, 
                  :contact, :misc_notes, :assets_attributes, :branch, 
                  :before_photos_attributes, :after_photos_attributes, :completed, :wo_type
  belongs_to :user
  has_many :assets
  has_many :before_photos
  has_many :after_photos
  accepts_nested_attributes_for :assets, :allow_destroy => true
  accepts_nested_attributes_for :before_photos, :allow_destroy => true
  accepts_nested_attributes_for :after_photos, :allow_destroy => true
  
  acts_as_gmappable
  
  #scope :current_branch, where("branch=350").order("wo_date ASC")
  scope :wo_current_branch, lambda{ |branch_number| where('branch = ?', branch_number)  }
  scope :ascending, order("wo_date ASC")
  scope :descending, order("wo_date DESC")
  scope :wo_completed, where('completed = ?', true)
  scope :wo_not_completed, where('completed = ?', false)
    
  BRANCH_OPTIONS = ['340','350','360']
  WORKORDER_TYPES = ['New Install','Pull','Swap','Follow Up']
  ASSET_STATUS_OPTIONS =  {  "" => "",
                             "Need to Order" => "0",
                             "New - Ordered"    => "1" ,
                             "New - On Site"    => "10" ,
                             "New - Tested"     => "99" ,
                             "Used - Ordered"   => "2"  ,
                             "Used - On Site"   => "11" ,
                             "Used - Torn Down" => "25" ,
                             "Used - Rebuilt"   => "76" ,
                             "Used - Tested"    => "100"}
 
  validates :wo_type, presence: true
  validates :user_id, presence: true
  validates :customer, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :phonenumber, presence: true
  validates :contact, presence: true
  validates :wo_date, presence: true
  validates :wo_duration, presence: true
  validates_length_of :misc_notes, :maximum => 200
  
 def googlemaps_link
   "http://maps.apple.com/maps?q=#{self.gmaps4rails_address.gsub(" ", "%20")}"
 end
     
 
 def gmaps4rails_address
   "#{self.street}, #{self.city}, #{self.state}"
 end
 
 
 def chronic_wo_date
   self.wo_date
 end
 
 def chronic_wo_date=(s)
   Chronic.time_class=Time.zone
   self.wo_date = Chronic.parse(s) if s
 end
 
 def raw_phonenumber
   self.phonenumber
 end
 
 def raw_phonenumber=(s)
   self.phonenumber=s.gsub(/\D/, '')
 end
end