class CreateAssetPhotos < ActiveRecord::Migration
  def change
    create_table :asset_photos do |t|
      t.integer :asset_id
      t.string :photo

      t.timestamps
    end
  end
end
