class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :end_user_id
      t.string :place_name
      t.text :caption
      t.timestamps
    end
  end
end
