class CreateAssetnotes < ActiveRecord::Migration
  def self.up
    create_table :assetnotes do |t|
      t.text :content
      t.timestamps
    end
  end

  def self.down
    drop_table :assetnotes
  end
end
