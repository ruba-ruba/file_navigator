require 'spec_helper'

describe Item do

  describe 'methods' do

    it 'should return full folder path' do
      folder = FactoryGirl.create(:folder)
      sub_folder = FactoryGirl.create(:folder, :parent_id => folder.id)
      file_1 = FactoryGirl.create(:item, :folder_id => nil)
      file_2 = FactoryGirl.create(:item, :folder_id => folder.id)
      file_3 = FactoryGirl.create(:item, :folder_id => sub_folder.id)


      file_1.folder_id.should be_nil
      file_2.folder_id.should eq(folder.id)
      file_3.folder_id.should eq(sub_folder.id)

      file_1.full_folder_path.should eq(nil)
      file_2.full_folder_path.should eq(folder.title)
      file_3.full_folder_path.should eq("#{folder.title}/#{sub_folder.title}")
    end

  end
  
end
