class CreateInformations < ActiveRecord::Migration
  def self.up
    create_table :informations do |t|
      t.references :writer
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :informations
  end
end
