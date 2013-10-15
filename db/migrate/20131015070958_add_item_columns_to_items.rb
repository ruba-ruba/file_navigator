class AddItemColumnsToItems < ActiveRecord::Migration
  def self.up
    add_attachment :items, :item
  end

  def self.down
    remove_attachment :items, :item
  end
end
