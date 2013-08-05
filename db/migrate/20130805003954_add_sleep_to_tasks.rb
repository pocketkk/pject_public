class AddSleepToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :sleep, :date
  end
end
