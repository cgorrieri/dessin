class CreateDiscutions < ActiveRecord::Migration
  def self.up
    create_table :discutions do |t|
      t.references :forum_part
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :discutions
  end
end
