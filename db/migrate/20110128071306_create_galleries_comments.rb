class CreateGalleriesComments < ActiveRecord::Migration
  def self.up
    create_table :galleries_comments do |t|
      t.references :from_user
      t.references :to_gallery
      t.text :message
      t.integer :see, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :galleries_comments
  end
end
