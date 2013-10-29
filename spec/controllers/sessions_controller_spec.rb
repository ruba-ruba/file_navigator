require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
      response.should render_template :new
    end
  end

  describe 'new session' do
    let!(:user){FactoryGirl.create(:user)}
    it 'should crate new sesseion' do

    end
  end

end
