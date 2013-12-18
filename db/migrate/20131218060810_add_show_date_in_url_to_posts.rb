class AddShowDateInUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :url_contains_date, :boolean, :default => false
  end
end
