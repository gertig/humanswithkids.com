class AddSimpleLayoutToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :simple_layout, :boolean, :default => false
  end
end
