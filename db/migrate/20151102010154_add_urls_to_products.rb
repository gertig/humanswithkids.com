class AddUrlsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :affiliate_url, :string
    add_column :products, :download_url, :string
  end
end
