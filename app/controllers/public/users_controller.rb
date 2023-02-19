class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    #@user = current_user
    @name = @user.name
    @users = @user.posts
  end

  def edit
    @user = current_user
  end

  def index
    @user = current_user
    @users = @user.posts
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_my_page_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :encrypted_password, :name, :address)
  end
end
