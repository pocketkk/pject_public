class ChangeDurationtoInteger < ActiveRecord::Migration
    change_column :workorders, :wo_duration, :integer
end