class CreateBeforePhotos < ActiveRecord::Migration
  def self.up
    create_table :before_photos do |t|
      t.integer :workorder_id
      t.string :photo
      t.timestamps
    end
  end

  def self.down
    drop_table :before_photos
  end
end
