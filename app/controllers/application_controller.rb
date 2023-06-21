class ApplicationController < ActionController::Base
    
  # ゲストユーザーかどうかを判断し、メッセージを表示
  def check_guest
    if current_end_user == EndUser.guest
      flash[:alert] = "ゲストユーザーは閲覧のみです。"
      redirect_to request.referer
    end
  end
end
