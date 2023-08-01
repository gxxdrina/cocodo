class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!

  ## 全会員の投稿一覧：新着順で表示
  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(6)
  end
  
  ## 全会員の投稿一覧：いいねの多い順で表示（いいねゼロも含む）
  def index_favorites
                      # favoritesテーブルと結合するPostモデルを取得
    @favorite_posts = Post.left_outer_joins(:favorites)
                      # Postレコードをidでグループ化
                     .group(:id)
                      # いいねの数で降順を指定
                     .order('COUNT(favorites.id) DESC')
                      # ページネーション
                     .page(params[:page]).per(6)
  end
  
  ## 一投稿者の投稿一覧
  def show
    @end_user = EndUser.find(params[:id])
    @posts = @end_user.posts.order(created_at: :desc).page(params[:page]).per(6)
  end
  
  def edit
    @end_user = current_end_user
  end
    
  def update
    if current_end_user != EndUser.guest
      # ゲストではないユーザー
      @end_user = current_end_user
      if @end_user.update(end_user_params)
        redirect_to end_user_path(@end_user), notice: "ユーザー情報を更新しました！"
      else
      # 入力に不備がある場合
        render :edit
      end
    else
      # ゲストユーザー
      flash[:alert] = "ゲストユーザーは編集できません！"
      redirect_to end_users_path
    end
  end
  
  ## 退会確認画面
  def confirm
  end
  
  ## 退会
  def resign
    @end_user = current_end_user
    @end_user.update(user_status: true) #true=退会
    
    reset_session
    flash[:notice] = "ご利用ありがとうございました。"
    redirect_to root_path
  end

  private
  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :profile_image)
  end
end
