class Public::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = PostComment.new(post_comment_params)
    comment.end_user_id = current_end_user.id
    comment.post_id = @post.id
    comment.save
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
