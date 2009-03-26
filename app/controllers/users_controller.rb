class UsersController < ApplicationController

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Rock Or Pop!"
      redirect_to root_url
    else
      render :new
    end
  end

  def index
    @users = User.all(:order => "created_at DESC")
  end

  def show
    @user = User.find(params[:id])
    @pairs = Pair.answered_by(@user)
  end
  
end
