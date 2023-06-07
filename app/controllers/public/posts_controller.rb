class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save
      redirect_to post_path(@post), notice: "投稿しました。"
    else
      flash[:notice] = "入力に誤りがあります。"
      render 'new'
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました。"
    else
      flash[:notice] = "入力に誤りがあります。"
      render 'edit'
    end
  end
  
  def destroy
    Post.find(params[:id]).destroy
    redirect_to posts_path
  end
  
  private
  def post_params
    params.require(:post).permit(:end_user_id, :place_name, :caption, post_images: [])
  end
end
