class AddWoTypeToWorrkorders < ActiveRecord::Migration
  def change
    add_column :workorders, :wo_type, :string
  end
end
