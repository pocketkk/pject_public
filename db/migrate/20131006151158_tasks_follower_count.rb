class TasksFollowerCount < ActiveRecord::Migration
  def up
    Task.all.each do |t|
        t.update_attribute :followers_count, t.followers.count
    end
  end

  def down
  end
end
