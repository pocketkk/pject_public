class AddCompleteToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :complete, :boolean, :default => false
  end
end
