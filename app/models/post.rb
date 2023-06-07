class Post < ApplicationRecord
  belongs_to :end_user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :end_user  # いいねした会員
  has_many_attached :post_images

  validates :place_name, presence:true, length:{ maximum: 20 }
  validates :caption, presence:true

  ## いいねしているかどうかを判定するメソッド
  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end


#   ## 投稿検索方法の分岐
#   def self.search_for(method, word)
#     if method == "perfect_match"
#       @post = Post.where("place_name LIKE?","#{word}")
#     elsif method == "forward_match"
#       @post = Post.where("place_name LIKE?","#{word}%")
#     elsif method == "backward_match"
#       @post = Post.where("place_name LIKE?","%#{word}")
#     elsif method == "partial_match"
#       @post = Post.where("place_name LIKE?","%#{word}%")
#     else
#       @post = Post.all
#     end
#   end  
end
