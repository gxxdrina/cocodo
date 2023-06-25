class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
    
  def destroy
    @post = Post.find(params[:post_id])
    PostComment.find(params[:id]).destroy
    redirect_to admin_post_path(@post)
  end
  
  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end