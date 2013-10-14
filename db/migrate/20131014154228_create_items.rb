class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.folder :references

      t.timestamps
    end
  end
end
