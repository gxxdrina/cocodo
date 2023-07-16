class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!
  
  # 会員一覧
  def index
    @end_users = EndUser.order(created_at: :desc).page(params[:page]).per(10)
    @posts = Post.all
  end

  # 一会員の投稿一覧
  def show
    @end_user = EndUser.find(params[:id])
    @posts = @end_user.posts.page(params[:page]).per(12)
  end
  
  def update
    end_user = EndUser.find(params[:id])
    end_user.update(end_user_params)
    pp end_user
    redirect_to admin_end_users_path, notice: "会員ステータスを変更しました！"
  end
  
  private
  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :profile_image, :user_status)
  end
end
