class AddAdditionalToWorkorders < ActiveRecord::Migration
  def change
    add_column :workorders, :lift_over_bar, :boolean, :default => false
    add_column :workorders, :stairs, :boolean, :default => false
    add_column :workorders, :open_for_business, :boolean, :default => false
    add_column :workorders, :under_permit, :boolean, :default => false
  end
end
