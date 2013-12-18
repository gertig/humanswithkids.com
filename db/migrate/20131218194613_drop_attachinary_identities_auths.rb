class DropAttachinaryIdentitiesAuths < ActiveRecord::Migration
  def change
  	drop_table :attachinary_files
  	drop_table :identities
  	drop_table :authentications
  end
end
