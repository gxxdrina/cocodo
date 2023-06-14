class Admin::SearchesController < ApplicationController

  def search
    @end_users = EndUser.all
    @posts = Post.all
  
    @search_posts = Post.search(params[:keyword])
    @search_end_users = EndUser.search(params[:keyword])
    if @search_posts.empty? && @search_end_users.empty?
      flash.now[:notice] = "キーワードに関連する 投稿・ユーザーが見つかりません。"
    end
  end
end
