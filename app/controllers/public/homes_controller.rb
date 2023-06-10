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
end
