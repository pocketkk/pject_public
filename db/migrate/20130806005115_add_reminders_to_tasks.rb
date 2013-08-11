class AddRemindersToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :reminder_date, :date
    add_column :tasks, :reminder_time, :datetime
  end
end
