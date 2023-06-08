class Public::EndUsersController < ApplicationController
  
  ## 全会員の投稿一覧：新着順で表示
  def index
    @posts = Post.order(created_at: :desc)
  end
  
  ## 全会員の投稿一覧：いいねの多い順で表示（いいねゼロも含む）
  def index_favorites
                      # favoritesテーブルと結合するPostモデルを取得
    @favorite_posts = Post.left_outer_joins(:favorites)
                      # Postレコードをidでグループ化
                     .group(:id)
                      # いいねの数で降順を指定
                     .order('COUNT(favorites.id) DESC')
  end
  
  ## １投稿者の投稿一覧
  def show
    @end_user = EndUser.find(params[:id])
    @posts = @end_user.posts
  end
  
  def edit
    @end_user = current_end_user
  end
  
  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to end_user_path(current_end_user), notice: "ユーザー情報を更新しました！"
    else
      flash[:notice] = "入力に誤りがあります！"
      render :edit
    end
  end
  
  def confirm
  end
  
  def resign
    @end_user = EndUser.find(params[:id])
    @end_user.update(user_status: true)
    reset_session
    flash[:notice] = "ご利用ありがとうございました。"
    redirect_to root_path
  end
  
  private
  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :profile_image)
  end
end
