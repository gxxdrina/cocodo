class Room < ApplicationRecord
  has_many :end_user_rooms
  has_many :chats
end
