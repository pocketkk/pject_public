# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  admin      :boolean
#  role       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :role, :password, :password_confirmation, 
                  :current_branch, :phone_number, :raw_phonenumber, :texts, :signature, :receive_mails
                  
  has_secure_password
  
  has_many :workorders
  has_many :updates
  has_many :assetnotes
  has_many :bugs
  has_many :parts
  has_many :comments
  
  attr_accessor :updating_password
  
  USER_ROLES = ['Regional Manager', 'Branch Manager', 'Sales', 'SSR', 'Supervisor', 'Rebuilder', 'Office','Installer', 'Production']
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  before_save :strip_whitespace
  
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  validates :role, presence: true
  validates :password, presence: true, length: { minimum: 6 }, :if => :should_validate_password?
  validates :password_confirmation, presence: true, :if => :should_validate_password?
  
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
