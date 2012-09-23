class AddAssetidToAssetnotes < ActiveRecord::Migration
  def change
    add_column :assetnotes, :asset_id, :integer
  end
end
