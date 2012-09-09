class CreateChemicals < ActiveRecord::Migration
  def self.up
    create_table :chemicals do |t|
      t.string :name
      t.integer :quantity
      t.integer :asset_id
      t.timestamps
    end
  end

  def self.down
    drop_table :chemicals
  end
end
