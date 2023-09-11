class Public::ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]
  
  def show
    @end_user = EndUser.find(params[:id])
    rooms = current_end_user.end_user_rooms.pluck(:room_id)
    end_user_rooms = EndUserRoom.find_by(end_user_id: @end_user.id, room_id: rooms)
    
    unless end_user_rooms.nil?
      @room = end_user_rooms.room
    else
      @room = Room.new
      @room.save
      EndUserRoom.create(end_user_id: current_end_user.id, room_id: @room.id)
      EndUserRoom.create(end_user_id: @end_user.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_end_user.chats.new(chat_params)
    render :validater unless @chat.save
  end
  
  
  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
  
  def reject_non_related
    end_user = EndUser.find(params[:id])
    unless current_end_user.following?(end_user) && end_user.following?(current_end_user)
      redirect_to posts_path
    end
  end

end
