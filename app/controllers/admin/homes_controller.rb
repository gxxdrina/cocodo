class Admin::HomesController < ApplicationController
  
  # 全投稿一覧
  def top
    @end_users = EndUser.all
    @posts = Post.all.page(params[:page]).per(9)
  end
end
