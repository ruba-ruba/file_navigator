require 'spec_helper'



describe ItemsController do

  render_views
  login_user

  describe 'GET index' do
    it 'should render index' do
      get :index
      response.should be_success
      response.should render_template :index
    end
  end

  describe 'get #new' do 
    it 'should render new' do
      xhr :get, :new
      response.should be_success
      response.should render_template :new
    end
  end

  describe 'get #edit' do
    let(:item){FactoryGirl.create(:item)} 
    it 'should render edit' do
      xhr :get, :edit, id: item.id
      response.should be_success
      response.should render_template :edit
    end
  end

  describe 'post#create' do
    let(:folder) { FactoryGirl.create(:folder) }
    it 'create new item without folder' do
      file =  fixture_file_upload('/test.csv', 'text/csv')
      item = {folder_id: nil, :item => file } 
      expect{ post :create, item: item }.to change(Item,:count).by(1)
    end
    it 'create new item with folder' do
      file =  fixture_file_upload('/test.csv', 'text/csv')
      item = {folder_id: folder.id, :item => file } 
      expect{ post :create, item: item }.to change(Item,:count).by(1)
      folder.items.should have(1).item
    end
    it 'create new item with folder' do 
      expect{ post :create, item: FactoryGirl.attributes_for(:item, item_file_name: nil) }.to change(Item,:count).by(0)
    end
  end

  describe "PUT#update duplicate column" do
    let!(:item){FactoryGirl.create(:item)}
    it 'should set item duplicate to false' do
      xhr :put, :update_duplicate_condition, id: item.id, duplicate: false
      item.save
      item.reload
      item.duplicate.should eq(false) 
    end
  end

  describe "PUT #update" do
    let!(:item) {FactoryGirl.create(:item, :item_file_name =>"Item")}
    let!(:folder) {FactoryGirl.create(:folder)}
    describe "valid attributes" do
      it "update item" do
        xhr :put, :update, id: item, item: FactoryGirl.attributes_for(:item, :item_file_name => "Item_Name", folder_id: nil)
        item.save
        item.item_file_name.should eq("Item")
      end
    end
    describe "invalid attributes" do
      it "should not update item" do
        xhr :put, :update, id: item, item: FactoryGirl.attributes_for(:item, :item_file_name => nil)
        item.save
        item.reload
        item.item_file_name.should eq("Item")
      end
    end
    describe "valid attrs & folder_id" do
      let!(:other_folder){FactoryGirl.create(:folder)}
      it "should update item" do
        xhr :put, :update, id: item, item: FactoryGirl.attributes_for(:item, folder_id: other_folder.id)
        item.reload 
        item.folder_id.should eq(other_folder.id) 
      end
    end
  end


  describe "DELETE destroy" do
    let!(:item) {FactoryGirl.create(:item)}
    it "delete item" do
      expect{xhr :delete, :destroy, id: item.id }.to change(Item,:count).by(-1) 
    end
  end

  describe 'DELETE destroy_by type' do
    let!(:item1){FactoryGirl.create(:item, :item_file_name => 'item1.txt')}
    let!(:item2){FactoryGirl.create(:item, :item_file_name => 'item2.txt')}
    it 'delete two items' do
      expect{xhr :delete, :destroy_by_type, items: [item1.id, item2.id] }.to change(Item,:count).by(-2) 
    end
  end
  

end
