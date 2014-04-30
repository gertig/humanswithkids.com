class Authentication < ActiveRecord::Base
  belongs_to :user
  has_many :tweets
end
