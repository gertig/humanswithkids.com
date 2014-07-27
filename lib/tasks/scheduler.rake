# In development
# $ foreman run rake publish_tweets
desc "Publish Scheduled Tweets"
task :publish_tweets => :environment do
  puts "Publish Tweets"
  Tweet.due.each do |tweet|
    tweet.publish
  end
  puts "done."
end

# task :send_reminders => :environment do
#     # User.send_reminders
# end

# desc "This is the committed worker"
# task :start_committed_worker => :environment do
#   puts "Start Committed Worker"
#   CommittedWorker.enqueue
# end

# desc "This is the HNAlert worker"
# task :alert_hn => :environment do
#     puts "Begin sending HN Alerts..."
#     # call this with $ rake alert_hn
#     HnAlertWorker.enqueue
#     puts "done."
# end
