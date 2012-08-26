class AddInstallinfoToWorkorders < ActiveRecord::Migration
  def change
    add_column :workorders, :wo_date, :date
    add_column :workorders, :wo_start, :time
    add_column :workorders, :wo_duration, :time
  end
end
