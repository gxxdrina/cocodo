class Favorite < ApplicationRecord
  belongs_to :end_user
  belongs_to :post
  
  #同じユーザーが同じ本に対して複数のコメントを投稿できない(一意性をチェック)
  validates_uniqueness_of :post_id, scope: :end_user_id
end
