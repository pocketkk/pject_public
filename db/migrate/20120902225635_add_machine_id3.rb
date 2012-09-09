class AddMachineId3 < ActiveRecord::Migration
  def change
    rename_column :machines_workorders, :machines_id, :phonenumber_remove
    add_column :machines_workorders, :machine_id, :integer
    remove_column :machines_workorders, :phonenumber_remove
  end
end
