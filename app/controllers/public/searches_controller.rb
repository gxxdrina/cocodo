class Public::SearchesController < ApplicationController

  def search
    @posts = Post.joins(:hashtags).search(params[:keyword])
    @end_users = EndUser.search(params[:keyword])
    
    if @posts.empty? && @end_users.empty?
      flash.now[:notice] = "キーワードに関連する 投稿・ユーザーが見つかりません。"
    end
  end
end
