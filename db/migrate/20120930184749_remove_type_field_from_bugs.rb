class RemoveTypeFieldFromBugs < ActiveRecord::Migration
  def up
    remove_column :bugs, :type
  end

  def down
  end
end
