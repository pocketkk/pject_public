class AddDoTypeToDayOffs < ActiveRecord::Migration
  def change
    add_column :day_offs, :do_type, :string
    remove_column :day_offs, :type
  end
end
