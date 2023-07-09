class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!
  # before_action :check_guest, only: [:create, :update, :destroy]

  def new
    @end_user = current_end_user
    @post = Post.new
    @post.post_images.build
  end
  
  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save
      redirect_to post_path(@post), notice: "投稿しました！！"
    else
       @end_user = current_end_user
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
    if @post.end_user != current_end_user 
      redirect_to post_path(@post)
    end
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました！"
    else
      flash[:notice] = "更新できませんでした！"
      render 'edit'
    end
  end
  
  def destroy
    Post.find(params[:id]).destroy
    flash[:notice] = "投稿を削除しました！"
    redirect_to end_user_path(current_end_user)
  end
  
  def hashtag
    if params[:name].nil?
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.posts.count}
    else
      name = params[:name]
      name = name.downcase  #小文字に変換
      @hashtag = Hashtag.find_by(hashname: name)
      @posts = @hashtag.posts
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.posts.count}
    end
  end
  
  private
  def post_params
    params.require(:post).permit(:end_user_id, :title, :caption, :hashbody, hashtag_ids: [], post_images: [])
  end
end
