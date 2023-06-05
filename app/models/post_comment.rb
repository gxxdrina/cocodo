class PostComment < ApplicationRecord
  belongs_to :end_user
  belongs_to :post
  
  validates :comment, presence: true
end
