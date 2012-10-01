class CreateParts < ActiveRecord::Migration
  def self.up
    create_table :parts do |t|
      t.string :name
      t.integer :qty
      t.text :comment
      t.integer :user_id
      t.integer :branch
      t.timestamps
    end
  end

  def self.down
    drop_table :parts
  end
end
