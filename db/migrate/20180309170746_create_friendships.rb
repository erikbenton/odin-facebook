class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :sender_id, null: false
      t.integer :acceptor_id, null: false
      t.boolean :accepted, null: false, default: false

      t.timestamps
    end
  end
end
