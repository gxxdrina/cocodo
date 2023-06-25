class Post < ApplicationRecord
  belongs_to :end_user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :hashtag_post_relations, dependent: :destroy
  has_many :hashtags, through: :hashtag_post_relations
  has_many_attached :post_images

  validates :title, presence:true, length:{ maximum: 20 }
  validates :caption, presence:true, length: { minimum: 10 }
  validates :post_images, presence:true


  ## いいねしているかどうかを判定するメソッド
  def favorited_by?(end_user)
    #引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するか
    favorites.exists?(end_user_id: end_user.id)
  end

  ## ハッシュタグ作成
  after_create do
    post = Post.find_by(id: self.id)
    # captionに打ち込まれたハッシュタグを検出
    hashtags = self.caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)

    post.hashtags = []
    hashtags.uniq.map do |hashtag|
      # ハッシュタグは先頭の'#'を外した上で保存
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#' '＃'))
      # byebug
      post.hashtags << tag
    end
  end
  
  ## ハッシュタグ更新
  before_update do
    post = Post.find_by(id: self.id)
    post.hashtags.clear
    hashtags = self.caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      # downcaseで小文字に置き換え、'#' '＃'を削除してキーワードを代入する
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#' '＃'))
      post.hashtags << tag
    end
  end

  ## 投稿・ハッシュタグのキーワード検索
  def self.search(keyword)
    if keyword.present?
      where(['title LIKE ?', "%#{keyword}%"]).where(['hashname LIKE ?', "%#{keyword}%"])
    else
      none  #キーワードがない場合はフラッシュメッセージを表示して結果を返さない
    end
  end
end
