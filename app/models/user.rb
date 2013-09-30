class User < ActiveRecord::Base
  attr_accessible :email, :name, :role, :super_user, :password, :password_confirmation,
                  :current_branch, :phone_number, :raw_phonenumber, :texts,
                  :signature, :receive_mails, :active

  has_secure_password

  has_many :workorders
  has_many :updates
  has_many :assetnotes
  has_many :bugs
  has_many :parts
  has_many :comments
  has_many :videos
  has_many :posts
  has_many :day_offs

  has_many :tasks, as: :taskable

  attr_accessor :updating_password

  USER_ROLES = ['Regional Manager', 'Branch Manager', 'Sales', 'SSR',
                'Supervisor', 'Rebuilder', 'Office','Installer',
                'Production']

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token, :strip_whitespace
  after_create :notify_admins, :welcome_letter, :new_update

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :role, presence: true
  validates :current_branch, presence: true
  validates :password, presence: true, length: { minimum: 6 },
    :if => :should_validate_password?
  validates :password_confirmation, presence: true,
    :if => :should_validate_password?

  scope :active_by_branch, lambda{ |branch| where(:active => true).
    where('current_branch = ?', branch) }
  scope :inactive_by_branch, lambda{ |branch| where(:active => false).
    where('current_branch = ?', branch) }
  scope :active, where(:active => true)
  scope :inactive, where(:active => false)
  scope :admins, where(:admin => true)
  scope :receives_texts, where(:texts => true)
  scope :receives_emails, where(:receive_mails => true)
  scope :receive_workorder_messages, where(role: ["Branch Manager",
   "Regional Manager",  "Rebuilder", "Installer"] )
  scope :stake_holders, where(role: ["Branch Manager",
   "Regional Manager",  "Rebuilder", "Installer"] )
  scope :managers, where(role: ["Branch Manager", "Regional Manager"])

  def notify_admins
    @client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
    # Create and send an SMS message
    @admins=User.admins
    @admins.each do |admin|
      unless admin.phone_number.blank?
        @client.account.sms.messages.create(
                 from: TWILIO_CONFIG['from'],
                 to: admin.phone_number,
                 body: self.new_message
               )
      end
    end
  end

  def past_due_workorders
    Workorder.wo_current_branch(self.current_branch).wo_not_completed.past_due
  end

  def new_update
    Updater.new(self, user: self, :update_type => :new)
  end

  def new_message
    "#{self.name.titleize} has signed up for Workorder Machine."
  end

  def welcome_letter
    PdfMailer.welcome_email(self).deliver
  end

  def completed_tasks
    tasks.where( :completed => true )
  end

    def incomplete_tasks
    tasks.where( :completed => false )
  end

  def should_validate_password?
    updating_password || new_record?
  end

  def raw_phonenumber
    self.phone_number
  end

  def raw_phonenumber=(s)
    self.phone_number=s.gsub(/\D/, '')
  end

  def strip_whitespace
    self.name = self.name.strip
    self.email = self.email.strip
  end

  private
      def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
      end
end
