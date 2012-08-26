class ChangePhoneNumbertoInteger < ActiveRecord::Migration
  def change
    rename_column :workorders, :phonenumber, :phonenumber_remove
    add_column :workorders, :phonenumber, :integer
    remove_column :workorders, :phonenumber_remove
  end
end