class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!

  def search
    @range = params[:range]
    if @range == "EndUser"
      @end_users = EndUser.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end
end
