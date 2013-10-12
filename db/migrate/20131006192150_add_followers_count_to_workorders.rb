class AddFollowersCountToWorkorders < ActiveRecord::Migration
  def change
    add_column :workorders, :followers_count, :integer, :default => 0
  end
end
