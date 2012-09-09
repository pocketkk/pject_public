class AddStatusToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :status, :string
    add_column :assets, :ready, :boolean
  end
end
