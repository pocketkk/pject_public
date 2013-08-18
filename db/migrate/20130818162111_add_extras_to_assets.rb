class AddExtrasToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :lift_over_bar, :boolean, :default => false
    add_column :assets, :stairs, :boolean, :default => false
    add_column :assets, :open_for_business, :boolean, :default => false
    add_column :assets, :under_permit, :boolean, :default => false
    remove_column :workorders, :lift_over_bar
    remove_column :workorders, :stairs
    remove_column :workorders, :open_for_business
    remove_column :workorders, :under_permit
  end
end
