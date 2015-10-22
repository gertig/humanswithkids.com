# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.humanswithkids.com"
# SitemapGenerator::Sitemap.sitemaps_host = "http://s3.amazonaws.com/humanswithkids-assets/"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new

# This gives us our sitemap at https://s3.amazonaws.com/humanswithkids.com/sitemaps/sitemap1.xml.gz

# To Run this in development you need to do:
# $ foreman run rake sitemap:refresh

# SitemapGenerator::Sitemap.public_path = 'tmp/'

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add archives_path, :priority => 0.9, :changefreq => 'daily'
  add about_path, :priority => 0.9, :changefreq => 'monthly'
  add products_path, :priority => 0.9, :changefreq => 'monthly'
  # add hire_me_path, :priority => 0.7, :changefreq => 'monthly'
  add feed_path, :priority => 0.7, :changefreq => 'daily' # RSS/Atom Feed
  add "/preschool-farm-fun", :priority => 0.7, :changefreq => 'weekly'
  add "/ios-for-parents-guide-to-iphone-ipad-ipod-security-and-safety", :priority => 1.0, :changefreq => 'daily'

  # iterate over all the posts and generate links for the published ones
  Post.find_each do |post|
    if !post.published_at.nil?
      time = post.published_at.strftime("%Y/%m")
      path = "/#{time}/#{post.slug}"
      add path, :lastmod => post.updated_at
    end
  end

end
