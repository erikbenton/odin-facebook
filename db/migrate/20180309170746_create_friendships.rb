class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.boolean :accepted, null: false, default: false

      t.timestamps
    end
    add_index :friendships, :sender_id
    add_index :friendships, :receiver_id
    add_index :friendships, [:sender_id, :receiver_id], unique: true
  end
end
