class AddCompleteToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :complete, :boolean, :default => 0
  end
end
