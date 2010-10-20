class CreateGalleries < ActiveRecord::Migration
  def self.up
    create_table :galleries do |t|
      t.references :user
      t.string :name
      t.string :categorie
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :galleries
  end
end
