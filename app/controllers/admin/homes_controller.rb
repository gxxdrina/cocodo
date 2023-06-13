class Admin::HomesController < ApplicationController
  def top
    @end_users = EndUser.all
    @posts = Post.all
  end
end
