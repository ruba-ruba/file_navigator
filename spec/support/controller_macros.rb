module ControllerMacros
  def login_admin
    before(:each) do
      admin = FactoryGirl.create(:admin)
      session[:user_id] = user.id
    end
  end

  def login_user
    before(:each) do
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id
    end
  end
end