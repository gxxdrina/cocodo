class Public::EndUsersController < ApplicationController
  
  ## 全会員の投稿を新着順で表示
  def index
    @end_user = current_end_user
    @end_users = EndUser.all
    @posts = Post.all
    
    # 投稿写真の１枚目のみを取得
    #@post = @end_user.posts
   # @post = Post.find(params[:id])
    #s@post.post_images.attach(params[:post][:post_images].first) if params[:post][:post_images].present?
  end
  
  ## 全会員の投稿をいいねの多い順で表示
  def index_favorites
    @end_user = current_end_user
    # @favorite_posts = Post.joins(:favorites).group(:id).order('COUNT(favorites.id) DESC')

    #いいね多い順 例
    #@books = Post.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
  end
  
  ## 投稿の詳細を表示
  def show
    @end_user = current_end_user
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
