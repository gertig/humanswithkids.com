class HomeController < ApplicationController
  def index
    @posts = Post.publisheds.order("published_at DESC").limit(20)
  
  end
end
