class Public::PostCommentsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :check_guest

  def create
    @post = Post.find(params[:post_id])
    comment = PostComment.new(post_comment_params)
    comment.end_user_id = current_end_user.id
    comment.post_id = @post.id
    comment.save
    # 非同期通信未実装
    redirect_to post_path(@post)
  end
  
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end
  
  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
