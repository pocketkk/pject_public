class Task < ActiveRecord::Base
  attr_accessible :assigned_to, :content, :completed, :chronic_due_date, :branch, :notes, :due_date, :context

  belongs_to :taskable, polymorphic: true

  scope :tasks_current_user, lambda{ |user| where('assigned_to = ? OR taskable_id = ?', user, user)  }
  scope :task_completed, where('completed = ?', true)
  scope :task_not_completed, where('completed = ?', false)
  scope :task_context, lambda { |context| where('context = ?', context)}

  CONTEXT = ["", "Office", "Phone", "Computer", "Home"]
  CONTEXT_OPTIONS = ["All","Office", "Phone", "Computer", "Home", ""]

  validates :content, presence: true

  def chronic_due_date
    self.due_date
  end

  def chronic_due_date=(s)
    Chronic.time_class=Time.zone
    self.due_date = Chronic.parse(s) if s
  end

end
