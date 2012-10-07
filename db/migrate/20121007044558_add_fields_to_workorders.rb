class AddFieldsToWorkorders < ActiveRecord::Migration
  def change
    add_column :workorders, :latitude, :float
    add_column :workorders, :longitude, :float
    add_column :workorders, :gmaps, :boolean
  end
end
