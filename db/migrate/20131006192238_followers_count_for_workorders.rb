class FollowersCountForWorkorders < ActiveRecord::Migration
  def up
    Workorder.all.each do |w|
        w.update_attribute :followers_count, w.followers.count
    end
  end

  def down
  end
end
