class AddCustomerinformationnotesToWorkorders < ActiveRecord::Migration
  def change
    add_column :workorders, :misc_notes, :string
  end
end
