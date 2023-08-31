class CreateEndUserRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :end_user_rooms do |t|
      t.integer :end_user_id
      t.integer :room_id
      t.timestamps
    end
  end
end
