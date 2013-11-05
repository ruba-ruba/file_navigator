class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :root_items

  helper_method :current_user
  helper_method :signed_in?
  helper_method :admin?
  helper_method :admin_user

  def root_items
    @root_folders = Folder.scoped
    @root_items = Item.without_folder
  end  

  def authorize
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !current_user.nil?
  end

  def admin?
    current_user.role == 'admin'
  end

  def admin_user
    redirect_to root_path, alert: "Not permitted" if current_user.role != 'admin'
  end




end
