class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.string :name
      t.string :email
      t.string :street
      t.string :zip
      t.string :city
      t.string :state
      t.string :country
      t.string :tracking_code
      t.text :html_string
      t.boolean :andrews_notified, :default => false
      t.boolean :fulfilled, :default => false
      t.boolean :customer_notified_of_shipment, :default => false
      t.boolean :cancelled, :default => false
      t.boolean :refunded, :default => false

      t.timestamps
    end
  end
end
