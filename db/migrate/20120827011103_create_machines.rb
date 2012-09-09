class CreateMachines < ActiveRecord::Migration
  def change
    drop_table :machines
    create_table :machines do |t|
      t.string :name

      t.timestamps
    end
  end
end
