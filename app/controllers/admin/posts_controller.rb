class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @end_users = EndUser.all
    @posts = Post.all
    
    @post = Post.find(params[:id])
    @end_user = @post.end_user

  end
  
  def destroy
    @post = Post.find(params[:id]).destroy
    redirect_to admin_end_user_path
  end
end
