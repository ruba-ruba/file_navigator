class UsersController < ApplicationController

  before_filter :authorize
  before_filter :admin_user

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.role = 'user'
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end


  def file_review
    files = Item.all
    @data = Item.duplicates(files)
  end

end
