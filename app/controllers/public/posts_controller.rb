class Public::PostsController < ApplicationController

  def new
    @user = current_user
    @post = Post.new
  end

  #検索フォーム用
  def search
   @user = current_user
   @tag_list = Tag.all
   @posts = Post.search(params[:keyword])
   @keyword = params[:keyword]
   render "index"
  end

  def search_tag
    @user = current_user
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts
    render "index"
  end


  def index
    @user = current_user
    @posts = Post.all
    @tag_list = Tag.all
  end

  def show
    @user = current_user
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @post_comment = PostComment.new
  end

  def edit
    @user = current_user
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:name].split(',')
     if @post.update(post_params)
       @old_relations = PostTag.where(post_id: @post.id)
        @old_relations.each do |relation|
         relation.delete
        end
        @post.save_tag(tag_list)
        redirect_to post_path(@post.id)
     else
        render :edit
     end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_tag(tag_list)
      redirect_to posts_path(@post)
    else
      render :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :introduction, :image, :tourist_spot, :tag)
  end
end
