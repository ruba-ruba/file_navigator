require 'spec_helper'

describe Folder do

  before do
    @folder = FactoryGirl.create(:folder)
  end

  subject { @folder }

  it { should respond_to(:title) }


    describe 'methods' do

    it 'should return full path' do
      folder = FactoryGirl.create(:folder, title: "a")
      sub_folder1 = FactoryGirl.create(:folder, title: "b", :parent => folder)
      sub_folder2 = FactoryGirl.create(:folder, title: "c", :parent => sub_folder1)
      sub_folder3 = FactoryGirl.create(:folder, title: "d", :parent => sub_folder2) 
      
      folder.parent_id.should be_nil
      sub_folder1.ancestry.should eq("#{folder.id}")
      sub_folder2.ancestry.should eq("#{folder.id}/#{sub_folder1.id}")
      sub_folder3.ancestry.should eq("#{folder.id}/#{sub_folder1.id}/#{sub_folder2.id}")


      folder.path.should be_nil
      sub_folder1.path.should eq("#{folder.title}")
      sub_folder2.path.should eq("#{folder.title}/#{sub_folder1.title}")
      sub_folder3.path.should eq("#{folder.title}/#{sub_folder1.title}/#{sub_folder2.title}")

      sub_folder3.path(sub_folder2).should eq("#{sub_folder2.title}")
      sub_folder3.path(sub_folder1).should eq("#{sub_folder1.title}/#{sub_folder2.title}")

    end

  end
  
end
