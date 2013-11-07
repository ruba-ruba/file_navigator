class AddDuplicateToItems < ActiveRecord::Migration
  def change
    add_column :items, :duplicate, :boolean, :default => true
  end
end
