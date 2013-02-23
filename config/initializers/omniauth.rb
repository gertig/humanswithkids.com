  
  Rails.application.config.middleware.use OmniAuth::Builder do
   # provider :twitter, TWITTER_CONSUMER_KEY, TWITTER_CONSUMER_SECRET
   # provider :facebook, FACEBOOK_APP_ID, FACEBOOK_APP_SECRET, :iframe => true, :scope => 'email, user_about_me,
   #                 user_activities,user_birthday,user_education_history,
   #                 user_likes, user_location,
   #                 publish_stream, friends_about_me' #, friends_birthday'

   # provider :github, GITHUB_CLIENT_ID, GITHUB_SECRET, scope: "repo" #not sure why something like "user,repo" is failing, url stuff
   provider :identity, :fields => [:name]
  end

  
