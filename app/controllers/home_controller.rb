class HomeController < ApplicationController
  def index
    # @posts = Post.publisheds.order("published_at DESC").limit(4)
    @posts = Post.featured_posts.limit(4)
  end
  
  def about
    
  end
  
end
