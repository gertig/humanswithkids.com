class User < ActiveRecord::Base
  # attr_accessible :email, :name, :role
  
  has_many :authentications #, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :tweets, :through => :authentications

  validates_uniqueness_of :name

  mount_uploader :avatar, AvatarUploader
  
  # scope :authors, where(role: "author")
  
  extend FriendlyId
  friendly_id :name, use: [:slugged]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #, :omniauthable, :omniauth_providers => [:twitter, :evernote]

         # :token_authenticatable has been removed from Devise 3.2.2 or greater

  def self.authors
    where(role: "author")
  end

  def add_twitter_account(auth)    
    authentications.build(:provider => auth["provider"], 
                          :uid => auth["uid"],
                          :name => auth["info"]["nickname"],
                          :access_token => auth["credentials"]["token"],
                          :access_secret => auth["credentials"].secret)
    save
  end

  def owns_tweet(tweet)
    self == tweet.authentication.user || tweet.authentication.name == "humanswithkids"
  end

  def visible_tweets
    hwk_auth = Authentication.where(name: "humanswithkids").first

    hwk_auth.nil? ? tweets : tweets + hwk_auth.tweets
  end

  def twitter_accounts
    # This adds @humanswithkids to the list for both Weiler and Gertig no matter who adds it
    hwk = Authentication.where(name: "humanswithkids").first

    accounts = authentications.to_a
    accounts.push(hwk) if !accounts.include?(hwk) && !hwk.nil?
    accounts
  end


end
