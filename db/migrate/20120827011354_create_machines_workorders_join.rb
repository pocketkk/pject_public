class CreateMachinesWorkordersJoin < ActiveRecord::Migration
  def up
    create_table 'machines_workorders', :id => false do |t|
      t.column 'machines_id', :integer
      t.column 'product_id', :integer
    end
  end

  def down
    drop_table 'machines_workorders'
  end
end
