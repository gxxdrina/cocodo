class Public::FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    favorite = current_end_user.favorites.new(post_id: @post.id)
    favorite.save
    respond_to do |format|
      format.js
    end
    # redirect_to request.referer
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_end_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end
  
  def index
    @favorites_posts = current_end_user.favorites.includes(:post)
  end
end
