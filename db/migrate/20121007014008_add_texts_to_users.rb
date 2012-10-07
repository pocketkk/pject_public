class AddTextsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :texts, :boolean, :default => false
  end
end
