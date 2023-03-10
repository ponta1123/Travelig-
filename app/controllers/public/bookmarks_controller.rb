class Public::BookmarksController < ApplicationController

 before_action :authenticate_user!

 def index
  @user = current_user
  @bookmarks = Bookmark.where(user_id: current_user.id)
 end

 def create
   @post = Post.find(params[:post_id])
   bookmark = @post.bookmarks.new(user_id: current_user.id)
   if bookmark.save
     redirect_to request.referer
   else
     redirect_to request.referer
   end
 end

 def destroy
   @post = Post.find(params[:post_id])
   bookmark = @post.bookmarks.find_by(user_id: current_user.id)
   if bookmark.present?
     bookmark.destroy
     redirect_to request.referer
   else
     redirect_to request.referer
   end
 end



end
