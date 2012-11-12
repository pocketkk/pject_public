class AddPartnumberToParts < ActiveRecord::Migration
  def change
    add_column :parts, :part_number, :string
    add_column :parts, :po_number, :string
    add_column :parts, :ordered, :boolean
  end
end
