class AddMachineId2 < ActiveRecord::Migration
  def change
    rename_column :machines_workorders, :workorders_id, :phonenumber_remove
    add_column :machines_workorders, :workorder_id, :integer
    remove_column :machines_workorders, :phonenumber_remove
  end
end
