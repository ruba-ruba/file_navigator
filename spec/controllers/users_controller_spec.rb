require 'spec_helper'

describe UsersController do
  render_views

  describe 'GET new' do
    it 'should render new' do
      get :new
      response.should be_success
      response.should render_template :new
    end
  end

  describe 'POST create' do 
    it 'should create new user' do
      expect{post :create, user: FactoryGirl.attributes_for(:user)}.to change(User,:count).by(1)
    end
    it 'should not create user' do
      expect{post :create, user: FactoryGirl.attributes_for(:user, email: nil)}.to change(User,:count).by(0)
    end
    it "should not create user with same email" do
      expect{post :create, user: FactoryGirl.attributes_for(:user, email: 'bob@mail.me')}.to change(User,:count).by(1)
      expect{post :create, user: FactoryGirl.attributes_for(:user, email: 'bob@mail.me')}.to change(User,:count).by(0)
    end
  end

end
