require 'spec_helper'



describe FoldersController do
  render_views
  let(:folder) {FactoryGirl.create(:folder)}

  describe "GET index" do
    it "should render index" do
      get :index
      response.should be_success
      response.should render_template :index
    end
  end

  describe 'GET show' do
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
  end

  describe "GET #edit" do
    it 'render with edit ' do
      get :edit, id: folder
      response.should render_template :edit
    end
  end

  describe "PUT #update" do
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
  end

  describe "DELETE destroy" do
    let!(:folder) {FactoryGirl.create(:folder)}
    it "delete the page" do
      expect{xhr :delete, :destroy, id: folder }.to change(Folder,:count).by(-1) 
    end
  end

end
