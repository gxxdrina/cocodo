class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  ## フォローする側のUserが持つRelationship
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 自分がフォローしているUserを取得するためのアソシエーション
  has_many :followings, through: :active_relationships, source: :followed

  ## フォローされる側のUserが持つRelationship
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分をフォローしているUserを取得するためのアソシエーション
  has_many :followers, through: :passive_relationships, source: :follower


  validates :name, length: { minimum: 1, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 100 }


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'default-image.jpg'
  end
  
  ## ゲストログイン方法
  def EndUser.guest
    find_or_create_by!(name: 'ゲスト' ,email: 'guest@example.com') do |end_user|
      end_user.password = SecureRandom.urlsafe_base64  #パスワードはランダムな文字列
    end
  end


  ## 会員検索方法の分岐
  # def self.search_for(method, word)
  #   if method == "perfect_match"
  #     @end_user = EndUser.where("name LIKE?", "#{word}")
  #   elsif method == "forward_match"
  #     @end_user = EndUser.where("name LIKE?","#{word}%")
  #   elsif method == "backward_match"
  #     @end_user = EndUser.where("name LIKE?","%#{word}")
  #   elsif method == "partial_match"
  #     @end_user = EndUser.where("name LIKE?","%#{word}%")
  #   else
  #     @end_user = EndUser.all
  #   end
  # end

  # ## フォローしたときの処理  
  # def follow(end_user)
  #   active_relationships.create(followed_id: end_user.id)
  # end

  # ## フォローを外すときの処理
  # def unfollow(end_user)
  #   active_relationships.find_by(followed_id: end_user.id).destroy
  # end

  # ## フォローしているか判定
  # def following?(end_user)
  #   followings.include?(end_user)
  # end
end
