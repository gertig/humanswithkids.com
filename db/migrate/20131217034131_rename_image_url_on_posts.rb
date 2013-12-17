class RenameImageUrlOnPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :image_url, :image_url_string
  end
end
