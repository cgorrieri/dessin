class CreateFriends < ActiveRecord::Migration
  def self.up
    create_table :friends, :id => false do |t|
      t.integer :user_id, :primary_key => true
      t.integer :friend_id, :primary_key => true
      t.timestamps
    end
  end

  def self.down
    drop_table :friends
  end
end
