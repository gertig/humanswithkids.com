class Tweet < ActiveRecord::Base
  belongs_to :authentication

  validates :authentication_id, presence: true
  validates :body, presence: true
  validates :send_at, presence: true

  def publish
    t = client.update(body)

    if t.is_a?(Twitter::Tweet)
      update_attributes(:sent => true)
      # save
    end
  end

  def send_at_english
    # date = send_at.strftime("%l:%M %p on %b %e, %Y")
    # date ? date : send_at
    send_at.strftime("%l:%M %p on %b %e, %Y")
  end

  def in_the_past
    send_at < DateTime.now
  end

  def self.due
    where("send_at < ? AND send_at > ? AND sent IS false", DateTime.now, 30.minutes.ago) #.where(sent: false)
  end

  def author
    authentication.name
  end

  def self.hwk_tweets
    hwk = Authentication.where(name: "humanswithkids").first
    hwk.nil? ? [] : hwk.tweets.order(send_at: :desc)
  end

  def self.mine(user)
    # where(: user)
  end

  def client

    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = authentication.access_token
      config.access_token_secret = authentication.access_secret
    end

  end
end
