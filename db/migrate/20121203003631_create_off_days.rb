class CreateOffDays < ActiveRecord::Migration
  def change
    create_table :off_days do |t|
      t.integer :user_id
      t.date :start_day
      t.date :end_day
      t.string :type

      t.timestamps
    end
  end
end
