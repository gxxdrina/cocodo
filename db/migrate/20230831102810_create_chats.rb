class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.integer :end_user_id
      t.integer :room_id
      t.string :message
      t.timestamps
    end
  end
end
