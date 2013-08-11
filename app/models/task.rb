class Task < ActiveRecord::Base
  attr_accessible :assigned_to, :content, :completed, :chronic_due_date,
   :branch, :notes, :due_date, :context, :sleep, :chronic_sleep,
   :chronic_reminder_time

  belongs_to :taskable, polymorphic: true

  scope :tasks_current_user, lambda{ |user| where('assigned_to = ? OR taskable_id = ?', user, user)  }
  scope :task_completed, where('completed = ?', true)
  scope :task_not_completed, where('completed = ?', false)
  scope :task_context, lambda { |context| where('context = ?', context)}

  CONTEXT = ["", "Office", "Phone", "Collections", "Home"]
  CONTEXT_OPTIONS = ["All","Office", "Phone", "Collections", "Home", ""]
  SLEEP_OPTIONS = ["",1,2,3,7,14,28]
  validates :content, presence: true

  def chronic_due_date
    self.due_date
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
    "#{self.context} | #{self.content} | http://www.workordermachine.com"
  end


end
