class AddBranchesToUsers < ActiveRecord::Migration
  def change
    users=User.all
    users.each do |user|
      user.assign_to_branch
    end
  end
end
