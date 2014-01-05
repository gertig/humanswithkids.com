class RenameAmountToPriceOnProducts < ActiveRecord::Migration
  def change
    rename_column :products, :amount, :price_in_cents

    drop_table :grumps
  end
end
