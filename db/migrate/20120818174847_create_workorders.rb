class CreateWorkorders < ActiveRecord::Migration
  def change
    create_table :workorders do |t|
      t.string :customer
      t.integer :user_id

      t.timestamps
    end
  end
end
