require 'spec_helper'

describe CommentsController do
  render_views
  let!(:folder_comment) {FactoryGirl.create(:folder_comment)}

  describe 'GET index' do 
    let!(:folder){FactoryGirl.create(:folder)}
    it 'should render comments for object' do
      get :index, folder_id: folder.id
      response.should be_success
      response.should render_template :index
    end
  end

  describe 'GET new' do
    let(:folder){FactoryGirl.create(:folder)}
    it 'should render new for object' do
      xhr :get, :new, folder_id: folder.id
      response.should be_success
      response.should render_template :new
    end
  end

  describe "POST create" do
    let!(:folder){FactoryGirl.create(:folder)}
    it 'should create comment' do
      expect{xhr :post, :create, comment: FactoryGirl.attributes_for(:folder_comment), folder_id: folder.id}.to change(Comment,:count).by(1)
    end
    it 'should not create comment' do
      expect{xhr :post, :create, comment: FactoryGirl.attributes_for(:folder_comment, content: nil), folder_id: folder.id}.to change(Comment,:count).by(0)
    end
  end

  describe "DELETE destroy" do
    let!(:folder){FactoryGirl.create(:folder)}
    let!(:comment){FactoryGirl.create(:folder_comment)}

    it "should delete comment" do
      expect{xhr :delete, :destroy, id: comment.id, folder_id: folder.id }.to change(Comment,:count).by(-1) 
    end
  end

end
