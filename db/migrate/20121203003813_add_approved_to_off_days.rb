class AddApprovedToOffDays < ActiveRecord::Migration
  def change
    add_column :off_days, :approved, :boolean, :default => false
  end
end
