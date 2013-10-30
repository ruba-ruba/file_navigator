class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :root_items

  def root_items
    @root_items = Item.without_folder
  end  

  def authorize
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

end
