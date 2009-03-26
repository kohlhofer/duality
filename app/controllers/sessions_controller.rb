class SessionsController < ApplicationController

  def new
  end
  
  def create
    if @user = User.authenticate(params[:login], params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Welcome back!"
      redirect_to root_url
    else
      flash.now[:error] = "Login failed."
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end

end
