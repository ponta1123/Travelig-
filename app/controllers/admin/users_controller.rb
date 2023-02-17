class Admin::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    #@post = Post.find(params[:id])
    @users = @user.posts
  end

  def edit
    @user = User.find(params[:id])
    @users = @user.posts
  end

  def update
    @user = User.find(params[:id])
    #@users = @user.posts
    @user.update(user_params)
    redirect_to admin_user_path(@user.id)
  end


  private

  def user_params
    params.require(:user).permit(:nick_name, :email, :prefectural, :city)
  end
end
