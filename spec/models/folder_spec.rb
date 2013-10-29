require 'spec_helper'

describe Folder do

  before do
    @folder = FactoryGirl.create(:folder)
  end

  subject { @folder }

  it { should respond_to(:title) }


    describe 'methods' do

    it 'should return full path' do
      folder = FactoryGirl.create(:folder)
      sub_folder1 = FactoryGirl.create(:folder, :parent => folder)
      sub_folder2 = FactoryGirl.create(:folder, :parent => sub_folder1) 
      
      folder.parent_id.should be_nil
      sub_folder1.ancestry.should eq("#{folder.id}")
      sub_folder2.ancestry.should eq("#{folder.id}/#{sub_folder1.id}")

      binding.pry
      folder.path.should be_nil
      sub_folder1.path.should eq("#{folder.title}")
      sub_folder2.path.should eq("#{folder.title}/#{sub_folder1.title}")
    end

  end
  
end
