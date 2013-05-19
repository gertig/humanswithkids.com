class AddMetaDescriptionToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :meta_description, :text
    add_column :posts, :image_url, :string
  end
end
