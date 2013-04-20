class AddProtectSlugFieldToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :protect_slug, :boolean, :default => false
  end
end
