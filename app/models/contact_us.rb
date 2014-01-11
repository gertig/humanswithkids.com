class ContactUs

  def self.email_hello(from = {})
    api_key = ENV["MAILGUN_API_KEY"]
    from_email = ENV["FROM_EMAIL"]
    # to_email = ENV["TO_EMAIL"]
    to_email = "hello@humanswithkids.com"
    api_url = "https://api.mailgun.net/v2/gertig.mailgun.org"
    # api_url = "https://api.mailgun.net/v2/mydomain.com"
     
    # Faraday gem
    connection = Faraday.new(:url => api_url) do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
     
    connection.basic_auth("api", api_key)
     
    data = {}
    data[:from] = "<#{from[:email]}>"
    data[:to] = "#{to_email}"
    data[:subject] = "[HWK] Contact Us - #{from[:name]}"
    data[:text] = "#{from[:name]}, #{from[:email]} - #{from[:body]}"
    data[:html] = "<p>#{from[:name]}</p><p>#{from[:email]}</p><p>#{from[:body]}</p>"
     
    response = connection.post do |req|
      req.url "messages"
      req.params = data
    end
  end

end