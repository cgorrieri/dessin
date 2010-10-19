class CreateFriendRequests < ActiveRecord::Migration
  def self.up
    create_table :friend_requests do |t|
      t.integer :sender_id
      t.integer :reciever_id
      t.text :message
      t.timestamps
    end
  end

  def self.down
    drop_table :friend_requests
  end
end
