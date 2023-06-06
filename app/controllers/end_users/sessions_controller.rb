class EndUsers::SessionsController < Devise::SessionsController
  def guest_sign_in
    end_user = EndUser.guest
    sign_in end_user  #ゲストユーザーをログイン状態にする
    redirect_to end_users_path, notice: 'ゲストユーザーでログインしました。'
  end
end