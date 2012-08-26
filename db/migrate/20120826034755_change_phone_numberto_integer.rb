class ChangePhoneNumbertoInteger < ActiveRecord::Migration
  def change
    rename_column :workorders, :phonenumber, :phonenumber_remove
    add_column :workorders, :phonenumber, :bigint
    remove_column :workorders, :phonenumber_remove
  end
end