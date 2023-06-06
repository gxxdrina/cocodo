class Admin::EndUsersController < ApplicationController
  
  def show
    @end_user = EndUser.find(params[:id])
    @posts = @end_user.posts
    @post = Post.new
  end
  
  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to end_user_path(current_end_user), notice: "ユーザー情報を更新しました"
    else
      render "edit"
    end
  end
  
  private
  def user_params
    params.require(:end_user).permit(:name, :introduction, :profile_image)
  end
end
