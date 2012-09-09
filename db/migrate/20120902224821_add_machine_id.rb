class AddMachineId < ActiveRecord::Migration
  def change
    rename_column :machines_workorders, :product_id, :phonenumber_remove
    add_column :machines_workorders, :workorders_id, :integer
    remove_column :workorders, :phonenumber_remove
  end
end
