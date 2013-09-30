class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :followable_id
      t.text :followable_type

      t.timestamps
    end
  end
end
