class AddContextToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :context, :string
  end
end
