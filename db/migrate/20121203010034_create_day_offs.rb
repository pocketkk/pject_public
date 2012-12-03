class CreateDayOffs < ActiveRecord::Migration
  def self.up
    create_table :day_offs do |t|
      t.date :start_date
      t.date :end_date
      t.string :type
      t.integer :user_id
      t.boolean :approved, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :day_offs
  end
end
