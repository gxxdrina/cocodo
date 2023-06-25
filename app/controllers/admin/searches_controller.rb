class Admin::SearchesController < ApplicationController

  def search
    @end_users = EndUser.all
    @posts = Post.all
  
    # .distinctで投稿の重複を削除
    @search_posts = Post.joins(:hashtags).search(params[:keyword]).distinct.page(params[:page]).per(9)
    @search_end_users = EndUser.search(params[:keyword]).page(params[:page]).per(10)
    
    if @search_posts.empty? && @search_end_users.empty?
      flash.now[:notice] = "キーワードに関連する 投稿・ユーザーが見つかりません。"
    end
  end
end
