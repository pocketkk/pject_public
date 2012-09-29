class AddCompleteToWorkorders < ActiveRecord::Migration
  def change
    add_column :workorders, :completed, :boolean
  end
end
