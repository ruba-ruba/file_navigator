require 'spec_helper'

describe Item do

  describe 'methods' do

    it 'should return full folder path' do
      folder = FactoryGirl.create(:folder)
      sub_folder = FactoryGirl.create(:folder, :parent => folder)

      file_1 = FactoryGirl.create(:item, :folder_id => nil)
      file_2 = FactoryGirl.create(:item, :folder_id => folder.id)
      file_3 = FactoryGirl.create(:item, :folder_id => sub_folder.id)


      file_1.folder_id.should be_nil
      file_2.folder_id.should eq(folder.id)
      file_3.folder_id.should eq(sub_folder.id)

      file_2.path(folder).should eq(folder.title)
      file_3.path(folder).should eq("#{folder.title}/#{sub_folder.title}")
    end

    it "should return duplicate files" do
      folder1 = FactoryGirl.create(:folder)
      folder2 = FactoryGirl.create(:folder)

      item1 = FactoryGirl.create(:item, item_file_name: 'item1', folder_id: folder1.id)
      item2 = FactoryGirl.create(:item, item_file_name: 'item1', folder_id: folder2.id)
      item3 = FactoryGirl.create(:item, item_file_name: 'another_item')
      item4 = FactoryGirl.create(:item, item_file_name: 'item1', item_file_size: '666')


      Item.duplicates.should eq({"item1" => [item1,item2]})
    end

  end
  
end
