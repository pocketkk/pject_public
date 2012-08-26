class AddAddressToWorkorders < ActiveRecord::Migration
  def change
    add_column :workorders, :street, :string
    add_column :workorders, :city, :string
    add_column :workorders, :state, :string
  end
end
