class AddUserToFollowers < ActiveRecord::Migration
  def change
    add_column :followers, :user_id, :integer
  end
end
