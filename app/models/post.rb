class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :permalink_path, :published, :published_at, :slug, :title
  
  scope :publisheds, where(:published => true)
  
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
    true #toggle this to false when changing back to the correct title
  end
  
  
end
