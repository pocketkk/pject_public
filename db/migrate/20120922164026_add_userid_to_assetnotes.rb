class AddUseridToAssetnotes < ActiveRecord::Migration
  def change
    add_column :assetnotes, :user_id, :integer
  end
end
