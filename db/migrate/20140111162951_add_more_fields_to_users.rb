class AddMoreFieldsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      
      ## Recoverable
      t.string  :avatar
      t.string  :twitter_handle
      t.text    :bio
      t.string  :catchphrase
      t.string  :google_plus
      t.string  :website
    end
  end
end
