class ApplicationController < ActionController::Base
  before_action :authenticate_end_user!, except: [:top, :about]
end
