class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.integer :user_id
      t.integer :branch_number

      t.timestamps
    end
  end
end
