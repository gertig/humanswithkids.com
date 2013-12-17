class Authentication < ActiveRecord::Base
  # attr_accessible :access_secret, :access_token, :provider, :uid
  belongs_to :user
end
