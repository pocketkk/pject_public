class AddBranchToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :branch, :integer
  end
end
