class Task < ActiveRecord::Base

  include Followable

  attr_accessible :assigned_to, :content, :completed, :chronic_due_date,
   :branch, :notes, :due_date, :context, :sleep, :chronic_sleep,
   :chronic_reminder_time, :followers_for

  belongs_to :taskable, polymorphic: true
  has_many :followers, as: :followable

  after_save :update_followers

  scope :tasks_current_user, lambda{ |user| where('assigned_to = ? OR taskable_id = ?', user, user)  }
  scope :task_completed, where('completed = ?', true)
  scope :task_not_completed, where('completed = ?', false)
  scope :task_context, lambda { |context| where('context = ?', context)}
  scope :due_today, where('due_date = ?', Time.zone.now.to_date)
  scope :current_user, lambda{ |user| where('assigned_to = ? OR taskable_id = ?', user, user)  }
  scope :asleep, where('sleep > ?', Time.zone.now.to_date)
  scope :not_asleep, where('sleep <= ?', Time.zone.now.to_date)
  scope :follows_for, lambda {|user| joins(:followers).where('user_id=?', user).task_not_completed}
  scope :for, lambda{ |user| where('assigned_to = ? OR taskable_id = ?', user, user)  }
  scope :include_followers, includes(:followers)

  CONTEXT = ["", "Office", "Phone", "Collections", "Fire-Call", "Sales-Lead", "Hand-Lead", "Home"]
  CONTEXT_OPTIONS = ["All","Office", "Phone", "Collections", "Fire-Call", "Sales-Lead", "Hand-Lead","Home", ""]
  SLEEP_OPTIONS = ["",1,2,3,7,14,28,365]

  validates :content, presence: true

  def chronic_due_date
    self.due_date
  end

  def update_followers
    @default_followers ||= []
    @default_followers.each do |new_follower|
      add_follower(new_follower) unless followers_as_users.include?(new_follower)
    end
    followers_as_users.each do |old_follower|
      remove_follower(old_follower) unless @default_followers.include?(old_follower)
    end
  end

  def followers_for=(users) #take user id and add user to follower list
    @default_followers = []
    users.each do |id|
      unless id.blank?
        user=User.find(id)
        @default_followers << user
      end
    end
  end

  def followers_for # need to return an array of user ids
    @default_follower_ids ||= []
    followers.each do |follower|
      @default_follower_ids << follower.user_id
    end
    @default_follower_ids
  end

  def complete!
    completed=true
    save
  end

  def chronic_due_date=(s)
    Chronic.time_class=Time.zone
    self.due_date = Chronic.parse(s) if s
  end

  def chronic_sleep
    self.sleep
  end

  def chronic_sleep=(s)
    Chronic.time_class=Time.zone
    self.sleep = Chronic.parse(Time.zone.now.to_date + s.to_i.days) if s
  end

  def chronic_reminder_time
    self.reminder_time.strftime("(%A) %b %-d at %l:%M%p") if self.reminder_time
  end

  def chronic_reminder_time=(s)
    Chronic.time_class=Time.zone
    self.reminder_time = Chronic.parse(s) if s
  end

  def reminder_msg
    "#{self.context} | #{self.content} | http://ac.workordermachine.com"
  end


end
