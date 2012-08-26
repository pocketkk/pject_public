class ChangePhoneNumbertoInteger < ActiveRecord::Migration
  def change
    change_column :workorders, :phonenumber, :integer
  end
end