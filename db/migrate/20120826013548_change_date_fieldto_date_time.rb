class ChangeDateFieldtoDateTime < ActiveRecord::Migration
  def change
    change_column :workorders, :wo_date, :datetime
  end
  
end