class DayOff < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :do_type, :user_id, :approved
  belongs_to :user
  
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :do_type, presence: true
 
  before_save :check_approved
  before_destroy :email_denied_to_user

  def num_days
    end_date - start_date
  end

  def approved!
    self.approved = true
    save!
  end

  def check_approved
    if approved == true && approved_was != true
      email_approval_to_user
    end
  end

  def email_approval_to_user
    PdfMailer.mail_time_off(self,user,"Approved").deliver
  end

  def email_denied_to_user
    PdfMailer.mail_time_off(self,user,"Denied").deliver
  end

end
