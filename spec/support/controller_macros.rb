module ControllerMacros
  def login_admin
    before(:each) do
      admin = FactoryGirl.create(:admin)
      #cookies.permanent[:remember_token] = admin.remember_token
    end
  end

  def login_user
    before(:each) do
      user = FactoryGirl.create(:user)
      #cookies.permanent[:remember_token] = user.remember_token
    end
  end
end