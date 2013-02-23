class User < ActiveRecord::Base
  attr_accessible :email, :name, :role
  
  has_many :authentications, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  
  scope :authors, where(role: "author")
  
  extend FriendlyId
  friendly_id :name, use: [:slugged]
  
  def omniauth_identity(auth)
    self.name = auth["info"]["name"]
    self.email = auth["info"]["email"] if auth["info"]["email"] 
    self.role = "author"
    
    authentications.build(
        :provider => auth['provider'], 
        :uid => auth['uid'].to_s,
        :access_token => auth['credentials']['token']
        )
  end
end
