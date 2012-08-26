class ChangePhoneNumbertoInteger < ActiveRecord::Migration
    change_column :workorders, :phonenumber, :integer

end