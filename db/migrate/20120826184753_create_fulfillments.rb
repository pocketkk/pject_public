class CreateFulfillments < ActiveRecord::Migration
  def change
    create_table :fulfillments do |t|
      t.integer :machine_id
      t.integer :workorder_id

      t.timestamps
    end
  end
end
