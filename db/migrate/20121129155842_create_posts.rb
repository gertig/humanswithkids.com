class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user
      t.string :title
      t.string :slug
      t.text :content
      t.boolean :published, :default => false
      t.string :permalink_path
      t.datetime :published_at

      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, :slug
  end
end
