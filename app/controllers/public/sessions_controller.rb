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
  
  ## ログイン後は自分の投稿一覧画面へ遷移
  def after_sign_in_path_for(resource)
    end_user_path(current_end_user)
  end

  ## 退会後はトップ画面へ遷移
  def after_sign_out_path_for(resource)
    root_path
  end
  
  ## ゲストは、新規登録を飛ばしてログイン
  def guest_sign_in
    end_user = EndUser.guest
    sign_in end_user 
    redirect_to end_users_path
  end
  
  ## 退会しているかを判断するメソッド
  def end_user_state
    # find_by メソッド：モデルから入力された email を検索し、該当する 1 件を取得する用途で使用
    @end_user = EndUser.find_by(email: params[:end_user][:email].downcase)
    
    # メールアドレスが取得できない場合
    if @end_user.nil?
      redirect_to new_end_user_session_path, notice: 'メールアドレスが違います。'
    else
      # valid_password?メソッド：find_by メソッドで特定したアカウントのパスワードと、ログイン画面で入力されたパスワードが一致しているかを判断
      if @end_user.valid_password?(params[:end_user][:password]) && @end_user.user_status
        redirect_to new_end_user_registration_path, notice: "こちらは、退会済みのアカウントです。別のメールアドレスで、再度ご登録をしてください。"
      # メールアドレスは存在するが、パスワードが違う場合
      elsif !@end_user.valid_password?(params[:end_user][:password])
        flash.now[:notice] = "パスワードが違います。"
        render :new
      end
    end

      ## 下記だと、パスワードが正しくてもログインできなくなる。
      # else
      # # メールアドレスは存在するが、パスワードが違う場合
      #   redirect_to new_end_user_session_path, notice: 'パスワードが違います。'
      # end
  end
end