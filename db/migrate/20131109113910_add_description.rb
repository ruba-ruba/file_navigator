class AddDescription < ActiveRecord::Migration
  def change
    add_column :folders, :description, :string
    add_column :items, :description, :string
  end
end
