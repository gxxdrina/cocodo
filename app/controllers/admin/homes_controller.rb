class Admin::HomesController < ApplicationController
  def top
    @end_users = EndUser.all
  end
end
