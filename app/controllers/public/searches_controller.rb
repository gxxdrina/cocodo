class Public::SearchesController < ApplicationController

  def search
    # .distinctで投稿の重複を削除
    @posts = Post.joins(:hashtags).search(params[:keyword]).distinct.page(params[:page]).per(9)
    @end_users = EndUser.search(params[:keyword]).page(params[:page]).per(10)
    
    if @posts.empty? && @end_users.empty?
      flash.now[:notice] = "キーワードに関連する 投稿・ユーザーが見つかりません。"
    end
  end
end
