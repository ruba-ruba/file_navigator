class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :item_id
      t.string :item_file_name
      t.integer :item_file_size
      t.integer :folder_id
      t.string :user_id 

      t.timestamps
    end
  end
end
