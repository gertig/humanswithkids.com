class DashboardController < ApplicationController
  before_filter :authenticate!
  
  def show
    @posts = current_user.posts
  end
end
