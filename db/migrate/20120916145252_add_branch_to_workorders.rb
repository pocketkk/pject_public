class AddBranchToWorkorders < ActiveRecord::Migration
  def change
    add_column :workorders, :branch, :integer
  end
end
