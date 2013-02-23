class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include PathsHelper
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  def user_signed_in?
    !!current_user
  end
  helper_method :user_signed_in?
  
  def authenticate!
    unless user_signed_in?
      redirect_to root_url, :alert => "You must be signed in as an author to do that."
      # redirect_to "/auth/identity", :alert => "You must have an account"
    end
  end
  helper_method :authenticate!

end
