# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :end_user_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  # サインイン後は自分の投稿一覧画面へ遷移
  def after_sign_in_path_for(resource)
    end_user_path(current_end_user)
  end

  # ログアウト後はトップ画面へ遷移
  def after_sign_out_path_for(resource)
    root_path
  end
  
  
  # 退会しているかを判断するメソッド
  def end_user_state
    # find_by メソッド：モデルから入力された email を検索し、該当する 1 件を取得する用途で使用
    @end_user = EndUser.find_by(email: params[:end_user][:email])
    # アカウントを取得できなかった場合は、このメソッドを終了する
  　return if !@end_user
  　
    # valid_password?メソッド：find_by メソッドで特定したアカウントのパスワードと、ログイン画面で入力されたパスワードが一致しているかを判断
    if @end_user.valid_password?(params[:end_user][:password]) && !@end_user.user_status
                                                             # && (@end_user.user_status == true) を簡略化
      flash[:danger] = "こちらは、退会済みのアカウントです。別のメールアドレスで、再度ご登録をしてください。"
      redirect_to new_end_user_registration_path
    else
      flash[:notice] = "項目を正しく入力してください。"
    end
  end
  
  # def reject_inactive_customer
  #   @customer = Customer.find_by(email: params[:customer][:email])
  #   if @customer
  #     if @customer.valid_password?(params[:customer][:password]) && !@customer.is_active
  #       flash[:danger] = 'お客様は退会済みです。申し訳ございませんが、別のメールアドレスをお使いください。'
  #       redirect_to new_customer_session_path
  #     end
  #   end
  # end
end
