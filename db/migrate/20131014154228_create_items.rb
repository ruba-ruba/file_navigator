class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :folder_id

      t.timestamps
    end
  end
end
