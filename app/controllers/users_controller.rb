class UsersController < ApplicationController

  before_action :logged_in_user, only:[:index, :edit, :update]
  before_action :correct_user, only:[:edit, :update]

  def new
    @user = User.new(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
    
  end

  def index
    @users = User.all
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation, :picture)
    end

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        redirect_to edit_user_path(current_user)
      end
    end
end
