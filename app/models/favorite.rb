class Favorite < ApplicationRecord
  belongs_to :end_user
  belongs_to :post
  
  #同じユーザーが同じ投稿に対して複数いいねができない(一意性をチェック)
  validates_uniqueness_of :post_id, scope: :end_user_id
end
