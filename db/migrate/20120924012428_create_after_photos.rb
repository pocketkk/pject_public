class CreateAfterPhotos < ActiveRecord::Migration
  def self.up
    create_table :after_photos do |t|
      t.integer :workorder_id
      t.string :photo
      t.timestamps
    end
  end

  def self.down
    drop_table :after_photos
  end
end
