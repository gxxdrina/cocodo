class Public::RelationshipsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    end_user = EndUser.find(params[:end_user_id])
    current_end_user.follow(end_user)
    redirect_to request.referer
  end
  
  def destroy
    end_user = EndUser.find(params[:end_user_id])
    current_end_user.unfollow(end_user)
    redirect_to request.referer
  end

  ## フォロー中の会員一覧
  def followings
    end_user = EndUser.find(params[:end_user_id])
    @end_users = end_user.followings
  end

  ## フォロワーの会員一覧  
  def followers
    end_user = EndUser.find(params[:end_user_id])
    @end_users = end_user.followers
  end
end
