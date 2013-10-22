require 'spec_helper'



describe FoldersController do
  render_views

  describe "GET index" do
    it "should render index" do
      get :index
      response.should be_success
      response.should render_template :index
    end
  end

  describe 'GET show' do
    let!(:folder) {FactoryGirl.create(:folder)}
    it 'should render show' do
      get :show, id: folder.id
      response.should be_success
      response.should render_template :show
    end
    it 'should contain folder' do
      folder2 = FactoryGirl.create(:folder, title: 'blah')
      get :show, id: folder2.id
      response.body.should  =~ /blah/ 
    end
  end

  describe 'get #new' do 
    it 'should render new' do
      xhr :get, :new
      response.should be_success
      response.should render_template :new
    end
  end

  describe 'post#create' do
    it 'creates new folder' do
      expect{post :create, folder: FactoryGirl.attributes_for(:folder)}.to change(Folder,:count).by(1)
    end
    it "invalid attr don't create folder" do
      expect{ post :create, folder: FactoryGirl.attributes_for(:folder, title: nil) }.to_not change(Folder,:count)
    end

    describe 'create with ancestry' do
      let!(:folder) {FactoryGirl.create(:folder)}
      it 'create subfolder' do
        expect{xhr :post, :create, folder: FactoryGirl.attributes_for(:folder, :title => 'New Title', :parent_id => folder.id)}.to change(Folder,:count).by(1)
        folder.reload
        folder.children.count.should == 1
        sub_folder = folder.children.first
        sub_folder.title.should eq("New Title")
      end
    end
  end

  describe "create item" do
    let(:folder) {FactoryGirl.create(:folder)}
    it 'create new item with folder' do
      @file = Item.new(folder_id: folder.id,:item => File.new(Rails.root + 'spec/factories/test.csv'))
      @file.save!
      get :show, id: folder.id
      response.body.should  =~ /test/ 
    end
  end

  describe "GET #edit" do
    let!(:folder) {FactoryGirl.create(:folder)}
    it 'render with edit ' do
      get :edit, id: folder
      response.should render_template :edit
    end
  end

  describe "PUT #update" do
    let!(:folder) {FactoryGirl.create(:folder)}
    describe "valid attributes" do
      it "update folder" do
        put :update, id: folder, folder: FactoryGirl.attributes_for(:folder, :title => "Fodler_Name")
        folder.save
        response.should redirect_to folder_path(folder)
      end
    end
    describe "invalid attributes" do
      it "not update folder" do
        put :update, id: folder, folder: FactoryGirl.attributes_for(:folder, title: nil)
        folder.save
        response.should render_template :edit
      end
    end
    describe 'update with ancestry' do
      let!(:folder) {FactoryGirl.create(:folder)}
      let!(:other_folder) {FactoryGirl.create(:folder)}
      it 'update with subfolder' do
        xhr :put, :update, id: folder, folder: FactoryGirl.attributes_for(:folder, :title => "Fodler_Name", :parent_id => other_folder.id)
        folder.reload
        folder.title.should eq("Fodler_Name")
      end
    end
  end

  describe "DELETE destroy" do
    let!(:folder) {FactoryGirl.create(:folder)}
    it "delete the page" do
      expect{xhr :delete, :destroy, id: folder }.to change(Folder,:count).by(-1) 
    end
  end

  describe "delete multiple" do
    let!(:folder1){FactoryGirl.create(:folder)}
    let!(:folder2){FactoryGirl.create(:folder)}
    let!(:item1){FactoryGirl.create(:item)}
    let!(:item2){FactoryGirl.create(:item)}

    it 'delete two folders' do
      expect{xhr :delete, :destroy_multiple, :folders => [folder1.id, folder2.id]}.to change(Folder,:count).by(-2) 
      expect{xhr :delete, :destroy_multiple, :items => [item1.id, item2.id]}.to change(Item,:count).by(-2)
    end
  end

end
