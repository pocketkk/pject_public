class AddCurrentbranchToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_branch, :integer
  end
end
