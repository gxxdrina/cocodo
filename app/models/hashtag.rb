class Hashtag < ApplicationRecord
  has_many :hashtag_post_relations, dependent: :destroy
  has_many :posts, through: :hashtag_post_relations
  
  validates :hashname, presence: true, length: { maximum: 50 }

end
