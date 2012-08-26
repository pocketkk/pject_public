class ChangeDurationtoInteger < ActiveRecord::Migration
  def change  
    rename_column :workorders, :wo_duration, :wo_duration_remove
    add_column :workorders, :wo_duration, :integer
    remove_column :workorders, :wo_duration_remove
  end  
end