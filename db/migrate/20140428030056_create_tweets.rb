class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.references :authentication
      t.string :body
      t.boolean :sent, :default => false
      t.datetime :send_at

      t.timestamps
    end

    add_index :tweets, :authentication_id
  end
end
