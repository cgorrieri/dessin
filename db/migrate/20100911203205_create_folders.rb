class CreateFolders < ActiveRecord::Migration
  def self.up
    create_table :folders do |t|
      t.references :user
      t.string :name
      t.string :categorie
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :folders
  end
end
