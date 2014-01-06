class AddFeaturesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :features, :string
  end
end
