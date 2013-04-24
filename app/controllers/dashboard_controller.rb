class DashboardController < ApplicationController
  before_filter :authenticate!
  
  def show
    @posts = current_user.posts.order("published_at DESC")
  end
  
end
