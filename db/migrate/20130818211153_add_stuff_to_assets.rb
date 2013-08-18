class AddStuffToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :disposition_existing_equipment, :text
    add_column :assets, :electrical_panel_location, :text
    add_column :assets, :water_heater_type, :string
    add_column :assets, :water_heater_capacity, :string
    add_column :assets, :closest_account, :string
  end
end
