class Public::EndUsersController < ApplicationController
  def index
  end
  
  ## 全投稿をいいねの多い順で表示
  def index_favorites
    # @favorite_posts = Post.joins(:favorites).group(:id).order('COUNT(favorites.id) DESC')
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def confirm
  end
  
  def resign
  end
end
