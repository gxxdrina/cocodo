class Public::HomesController < ApplicationController
  
  def top
    ## 過去1週間で、いいねが多い順に4つの投稿を取得
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @posts = Post.left_joins(:favorites)  #いいねが存在しない投稿も取得
                 .where(favorites: { created_at: from...to })  #いいねの作成日時でフィルタリング
                 .group(:id)  #重複を排除
                 .order('COUNT(favorites.id) DESC')  #いいね数の降順で投稿を並び替え
                 .limit(4)  #4つの投稿を取得
  end
  
  def about
  end
  
  # def guest_sign_in
  #   user = User.find_or_create_by!(email: 'guest@example.com') do |user|
  #     user.password = SecureRandom.urlsafe_base64
  #     # user.skip_confirmation!  # Confirmable を使用している場合は必要
  #     # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
  #   end
  #   sign_in user
  #   redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  # end
end
