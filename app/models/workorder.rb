require 'chronic'

class Workorder < ActiveRecord::Base
  attr_accessible :customer, :street, :city, :state, :wo_date, 
                  :wo_duration, :chronic_wo_date, :phonenumber, 
                  :contact, :misc_notes, :assets_attributes, :branch
  belongs_to :user
  has_many :assets
  accepts_nested_attributes_for :assets, :allow_destroy => true
  
  #scope :current_branch, where("branch=350").order("wo_date ASC")
  scope :wo_current_branch, lambda{ |branch_number| where('branch = ?', branch_number)  }
  scope :ascending, order("wo_date ASC")
  
  BRANCH_OPTIONS = ['340','350','360']
 
  validates :user_id, presence: true
  validates :customer, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :phonenumber, presence: true
  validates_length_of :phonenumber, :in => 7..32, :allow_blank => true
  validates :contact, presence: true
  validates :wo_date, presence: true
  validates :wo_duration, presence: true
 
 def chronic_wo_date
   self.wo_date
 end
 
 def chronic_wo_date=(s)
   Chronic.time_class=Time.zone
   self.wo_date = Chronic.parse(s) if s
 end


end
