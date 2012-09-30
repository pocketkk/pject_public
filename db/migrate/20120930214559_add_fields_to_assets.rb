class AddFieldsToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :water_plumbing, :string
    add_column :assets, :drain_plumbing, :string
    add_column :assets, :electrical_option, :string
  end
end
