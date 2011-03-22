class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :poster
      t.string :artist
      t.string :album
      t.string :link
      t.string :comment
      t.boolean :down

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
