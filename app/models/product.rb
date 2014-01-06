class Product < ActiveRecord::Base

  def send_purchase_email(params = {})
    email   = params[:stripeEmail]
    name    = params[:stripeShippingName]
    street  = params[:stripeShippingAddressLine1]
    zip     = params[:stripeShippingAddressZip]
    city    = params[:stripeShippingAddressCity]
    state   = params[:stripeShippingAddressState]
    country = params[:stripeShippingAddressCountry]
    html    = params[:html]



    api_key = ENV["MAILGUN_API_KEY"]
    # api_url = "https://api.mailgun.net/v2/drip.mailgun.org"
    api_url = "https://api.mailgun.net/v2/gertig.mailgun.org"
    # api_url = "https://api.mailgun.net/v2/mydomain.com"
     
    # Using the Faraday gem
    connection = Faraday.new(:url => api_url) do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      # faraday.response :json, :content_type => /\bjson$/
      faraday.adapter Faraday.default_adapter
    end
     
    connection.basic_auth("api", api_key)
     
    data = {}
    data[:from] = "HWK Purchase <gertig@humanswithkids.com>"
    data[:to] = "andrew.gertig@gmail.com"
    data[:subject] = "A Bike Purchase"
    data[:text] = "#{name}, #{features} - #{description}"
    # data[:html] = "<h1>#{name}</h1><h2>#{description}</h2><br><p>#{params[:stripeShippingAddressLine1]}</p>"
    data[:html] = html
     
    response = connection.post do |req|
      req.url "messages"
      req.params = data
    end

    puts "RESPONSE"
    puts response.body

    Rails.logger.debug("[debug] : #{response.body}" );


  end

  def send_complex_message
    data = Multimap.new
    data[:from] = "Excited User <me@samples.mailgun.org>"
    data[:to] = "foo@example.com"
    data[:cc] = "baz@example.com"
    data[:bcc] = "bar@example.com"
    data[:subject] = "Hello"
    data[:text] = "Testing some Mailgun awesomness!"
    data[:html] = "<html>HTML version of the body</html>"
    data[:attachment] = File.new(File.join("files", "test.jpg"))
    data[:attachment] = File.new(File.join("files", "test.txt"))
    RestClient.post "https://api:key-3ax6xnjp29jd6fds4gc373sgvjxteol0"\
    "@api.mailgun.net/v2/samples.mailgun.org/messages", data
  end

end
