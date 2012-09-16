class AddUseridToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :user_id, :integer
  end
end
