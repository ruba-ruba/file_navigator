class SessionsController < ApplicationController
  
  def new
    respond_to do |format|
      format.html
      format.js
    end
  end  

  def create
    user = User.find_by_email(params[:email])
    if user && user.password == params[:password]
      session[:user_id] = user.id
      redirect_to root_url, notice: "Welcome #{user.email}"
    else
      flash.now[:message] = "Invalid email && password combination"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

end
