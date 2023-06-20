class HashtagPostRelation < ApplicationRecord
  ## 中間テーブル
  belongs_to :post
  belongs_to :hashtag
  
  validates :post_id, presence: true
  validates :hashtag_id, presence: true
end
