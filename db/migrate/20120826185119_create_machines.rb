class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :model_number
      t.string :serial_number
      t.integer :option_id
      t.string :misc_notes

      t.timestamps
    end
  end
end
