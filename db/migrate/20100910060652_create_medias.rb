class CreateMedias < ActiveRecord::Migration
  def self.up
    create_table :medias do |t|
      t.references :media_container, :polymorphic => true
      t.string :image_file_name # Original filename
      t.string :image_content_type # Mime type
      t.integer :image_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :medias
  end
end
