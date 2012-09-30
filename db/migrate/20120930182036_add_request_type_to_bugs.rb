class AddRequestTypeToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :request_type, :text
  end
end
