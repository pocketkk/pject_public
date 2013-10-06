class AddCounterCacheToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :followers_count, :integer, :default => 0
  end
end
