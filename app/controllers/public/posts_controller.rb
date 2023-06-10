class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!
  
  def new
    @end_user = current_end_user
    @post = Post.new
    @post.post_images.build
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
  
  ## 投稿の詳細画面
  def show
    @post = Post.find(params[:id])
    @end_user = @post.end_user
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    # if @post.end_user != current_end_user 
    #   redirect_to post_path(@post)
    # end
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
