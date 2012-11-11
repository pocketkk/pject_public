class AddAssignedToWorkorders < ActiveRecord::Migration
  def change
    add_column :workorders, :assigned_to, :integer
  end
end
