atom_feed do |feed|
  feed.title @title
  feed.updated @updated
  # feed.title("My great blog!")
  # feed.updated(@posts[0].created_at) if @posts.length > 0

  @posts.each do |post|
    next if post.updated_at.blank?
    
    feed.entry(post) do |entry|
      entry.url(blogpost_path(post))
      entry.title(post.title)
      entry.content(markdown(post.content).to_html.html_safe, :type => 'html')
      
      # the strftime is needed to work with Google Reader.
      entry.updated(post.published_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 

      entry.author do |author|
        author.name("Andrew Gertig")
      end
    end
  end
end

# atom_feed :language => 'en-US' do |feed|
#   feed.title @title
#   feed.updated @updated
# 
#   @news_items.each do |item|
#     next if item.updated_at.blank?
# 
#     feed.entry( item ) do |entry|
#       entry.url news_item_url(item)
#       entry.title item.title
#       entry.content item.content, :type => 'html'
# 
#       # the strftime is needed to work with Google Reader.
#       entry.updated(item.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 
# 
#       entry.author do |author|
#         author.name entry.author_name)
#       end
#     end
#   end
# end