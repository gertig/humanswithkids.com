class Authentication < ActiveRecord::Base
  belongs_to :user
  has_many :authentications
end
