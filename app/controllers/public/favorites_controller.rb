class Public::FavoritesController < ApplicationController
  before_action :authenticate_end_user!
  
  def create
    @post = Post.find(params[:post_id])
    favorite = current_end_user.favorites.new(post_id: @post.id)
    favorite.save
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_end_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end
  
  def index
    # 最近いいねした投稿が一番上にくるように並び替えして表示
    @favorite_posts = Kaminari.paginate_array(current_end_user.favorites.includes(:post)
                      .order(created_at: :desc)).page(params[:page]).per(6)
  end
end
