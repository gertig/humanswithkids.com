class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  
  def new
    puts "New Session"
  end
  
  def not_today
    redirect_to root_url
  end

  def create
    puts "Trying to Login"
    oa = request.env["omniauth.auth"]
    
    # raise oa.to_yaml
      
    @authentication = Authentication.find_by_provider_and_uid(oa['provider'].to_s, oa['uid'].to_s)

    if @authentication
      puts "This means the USER has already connected this account before."
      @authentication.update_attribute(:access_token, oa["credentials"]["token"])
      session[:user_id] = @authentication.user.id
      redirect_to dashboard_path, notice: "Welcome!"
    elsif current_user
      puts "User is already logged in so add this method to their list of authentications"
      current_user.authentications.create!(provider: oa['provider'], 
                      uid: oa['uid'].to_s,
                      access_secret: oa['credentials']['secret'],
                      access_token: oa['credentials']['token']
                      )
      redirect_to root_url, notice: "New Connection Successful."
    else
      
      user = User.new
      user.omniauth_identity(oa)
      
      if user.save
        session[:user_id] = user.id
        flash_notice = "Signed in!"
      else
        session[:user_id] = nil
        flash_notice = "You aren't allowed"
      end
      
      redirect_to root_url, notice: flash_notice

    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end
  
  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  
end