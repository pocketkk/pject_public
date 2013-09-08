require 'chronic'

class Workorder < ActiveRecord::Base
  attr_accessible :customer, :street, :city, :state, :wo_date,
                  :wo_duration, :chronic_wo_date, :phonenumber, :raw_phonenumber,
                  :contact, :misc_notes, :assets_attributes, :branch,
                  :before_photos_attributes, :after_photos_attributes, :completed,
                  :wo_type, :assigned_to
  belongs_to :user
  has_many :assets
  has_many :before_photos
  has_many :after_photos
  has_many :comments, as: :commentable
  has_many :tasks, as: :taskables

  after_create :text_users, :email_users, :update_updates

  accepts_nested_attributes_for :assets, :allow_destroy => true
  accepts_nested_attributes_for :before_photos, :allow_destroy => true
  accepts_nested_attributes_for :after_photos, :allow_destroy => true

  acts_as_gmappable :process_geocoding => false

  #scope :current_branch, where("branch=350").order("wo_date ASC")
  scope :wo_current_branch, lambda{ |branch_number| where('branch = ?',
                            branch_number)  }
  scope :ascending, order("wo_date ASC")
  scope :descending, order("wo_date DESC")
  scope :wo_completed, where('completed = ?', true)
  scope :wo_not_completed, where('completed = ?', false)
  scope :wo_has_date, where('wo_date IS NOT NULL')
  scope :wo_no_date, where('wo_date IS NULL')
  scope :today, where('wo_date BETWEEN ? AND ?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day)
  scope :tomorrow, where('wo_date BETWEEN ? AND ?', Time.zone.now.beginning_of_day+1.day, Time.zone.now.end_of_day+1.day)
  scope :wo_recently_completed, where('completed = ?', true).limit(4).order("wo_date DESC")
  scope :past_due, where('wo_date < ?', Time.zone.now.beginning_of_day).where('completed = ?', false)


  BRANCH_OPTIONS          = ['110','120','130','140','210','220','230','240',
                            '310','320','330','340','350','360','410','420',
                            '430','440','450','710']
  WORKORDER_TYPES         = ['New Install','Pull','Swap','Follow Up']
  WORKORDER_TYPES_SEARCH  = ['','New Install','Pull','Swap','Follow Up']
  ASSET_STATUS_OPTIONS    = {  ""                   => "",
                             "Need to Order"        => "0",
                             "New - Ordered"        => "1" ,
                             "New - On Site"        => "10" ,
                             "New - Tested"         => "97" ,
                             "Used - Ordered"       => "2"  ,
                             "Used - On Site"       => "11" ,
                             "Used - Torn Down"     => "25" ,
                             "Used - Rebuilt"       => "76" ,
                             "Used - Tested"        => "98" ,
                             "Delivered/Not Installed" => "99",
                             "Machine Installed" => "100"}

  validates :wo_type, presence: true
  validates :user_id, presence: true
  validates :customer, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :phonenumber, presence: true
  validates :contact, presence: true
  validates :wo_duration, presence: true
  validates_length_of :misc_notes, :maximum => 200

 def users_to_notify_by_text
  User.active_by_branch(self.branch).receive_workorder_messages.receives_texts
 end

 def users_to_notify_by_email
  User.active_by_branch(self.branch).receive_workorder_messages.receives_emails
 end

 def update_updates
  update = self.user.updates.new
  update.feed_item=self.update_msg
  update.save
 end

def update_msg
  "#{self.user.name.titleize} created a #{self.wo_type.downcase} workorder for #{self.customer.titleize}."
end

 def text_users
  @client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
  if users_to_notify_by_text
    users_to_notify_by_text.each do |user|
       unless user.phone_number.blank?
         # Create and send an SMS message
         @client.account.sms.messages.create(
           from: TWILIO_CONFIG['from'],
           to: user.phone_number,
           body: "A #{self.wo_type.downcase} workorder for #{self.customer.titleize} has been created! www.workordermachine.com/workorders/#{self.id}")
      end
    end
  end
 end

 def email_users
  if users_to_notify_by_email
    users_to_notify_by_email.each do |user|
      PdfMailer.mail_workorder(self,user,"New").deliver
    end
  end
 end

 def googlemaps_link
   "http://maps.apple.com/maps?q=#{self.gmaps4rails_address.gsub(" ", "%20")}"
 end

 def googlemaps_image
  "http://maps.googleapis.com/maps/api/staticmap?center=#{gmaps4rails_address}&zoom=14&size=400x400&markers=color:blue%7Clabel:A%7C#{gmaps4rails_address}&sensor=false"
 end

 def gmaps4rails_address
   "#{self.street}, #{self.city}, #{self.state}"
 end

 def chronic_wo_date
   self.wo_date.strftime("(%A) %b %-d at %l:%M%p") unless self.wo_date.nil?
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
