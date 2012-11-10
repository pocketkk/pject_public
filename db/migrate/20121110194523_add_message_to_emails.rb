class AddMessageToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :message, :text
  end
end
