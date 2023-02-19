class Public::PostsController < ApplicationController
  def new
    @user = current_user
    @post = Post.new
  end

  def index
    @user = current_user
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :introduction, :image, :tourist_spot)
  end
end
