class AddPhonenumberToWorkorders < ActiveRecord::Migration
  def change
    add_column :workorders, :phonenumber, :string
    add_column :workorders, :contact, :string
  end
end
