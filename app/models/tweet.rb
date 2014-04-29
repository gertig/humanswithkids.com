class Tweet < ActiveRecord::Base
  belongs_to :authentication

  def publish
    t = client.update(body)

    if t.is_a?(Twitter::Tweet)
      update_attributes(:sent => true)
      # save
    end
  end

  def send_at_english
    send_at.strftime("%l:%M %p on %b %e, %Y")
  end

  def in_the_past
    send_at < DateTime.now
  end

  def self.due
    where("send_at < ? AND sent IS false", DateTime.now) #.where(sent: false)
  end

  def author
    authentication.name
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
