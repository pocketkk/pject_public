class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :content
      t.integer :taskable_id
      t.string :taskable_type
      t.integer :assigned_to

      t.timestamps
    end
    add_index :tasks, [:taskable_id, :taskable_type]
  end
end
