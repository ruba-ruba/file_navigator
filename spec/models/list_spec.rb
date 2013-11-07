require 'spec_helper'

describe List do
  describe 'methods' do
    it "should return duplicate files" do
      folder1 = FactoryGirl.create(:folder)
      folder2 = FactoryGirl.create(:folder)

      item1 = FactoryGirl.create(:item, item_file_name: 'item1', folder_id: folder1.id)
      item2 = FactoryGirl.create(:item, item_file_name: 'item1', folder_id: folder2.id)
      item3 = FactoryGirl.create(:item, item_file_name: 'another_item')
      item4 = FactoryGirl.create(:item, item_file_name: 'item1', item_file_size: '666')

      files = [item1,item2,item3,item4]
      List.duplicates(files).should eq({"item1" => [item1,item2]})
    end
  end
end
