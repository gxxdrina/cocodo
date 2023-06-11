class Post < ApplicationRecord
  belongs_to :end_user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many_attached :post_images
  # has_many :favorited_users, through: :favorites, source: :end_user  # いいねした会員


  validates :place_name, presence:true, length:{ maximum: 20 }
  validates :caption, presence:true

  ## いいねしているかどうかを判定するメソッド
  def favorited_by?(end_user)
    #引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するか
    favorites.exists?(end_user_id: end_user.id)
  end

  ## 会員のキーワード検索
  def self.search(keyword)
    if keyword.present?
      where(['place_name LIKE ?', "%#{keyword}%"])
    else
      none  #キーワードがない場合はフラッシュメッセージを表示して結果を返さない
    end
  end
end
