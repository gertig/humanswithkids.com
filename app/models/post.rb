class Post < ActiveRecord::Base
  include ActionView::Helpers
  
  belongs_to :user
  attr_accessible :content, :permalink_path, :published, :published_at, :slug, :title, :protect_slug
  
  scope :publisheds, where(:published => true)
  
  scope :next,     lambda {|published_at| where("published_at > ?", published_at).order("published_at ASC") }
  scope :previous, lambda {|published_at| where("published_at < ?", published_at).order("published_at DESC") }
  
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  
  before_save :published_post
  
  def published_post
    if self.published == true && self.published_at.nil?
     self.published_at = Time.now
    end
  end
  
  def published_on
    !published_at.nil? ? published_at.strftime("%B %e, %Y") : "Private"
  end
  
  def should_generate_new_friendly_id?
    !self.protect_slug
    # Set protect_slug to true to keep the current url no matter if you change the Post title
    # this makes sure that the Hack a Marathon slug doesn't get changed by accident
    # If I want to make something match my old wordpress urls the way to do it is by
    # 1. Create the post with the words in the url as the title.
    #    - A url like this: /2011/05/rails-backbone-js-example-screencast/
    #      needs a Post title like this: Rails backbone js example screencast and the Protect check box checked    
  end
  
  def next
    posts = Post.next(self.published_at)
    posts.any? ? posts.first : false
  end

  def previous
    posts = Post.previous(self.published_at)
    posts.any? ? posts.first : false
  end
  
  def meta_description
    "#{strip_tags(strip_links(markdown(content.slice(0, 154).strip).to_html)).squish}..."
  end
  
  def markdown(text)
    RedcarpetCompat.new(text, :fenced_code, :gh_blockcode)
  end
  
  def tweet_url(url)
    if published_at > Time.at(1361061867)
      "#{url.gsub("www.", "")}/"
    else
      url
    end
  end
  
  
end
