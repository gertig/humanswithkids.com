module OmniAuth::Strategies

   class Identity
     # def request_phase
     #   redirect '/'
     # end
     
     def registration_form
       redirect '/'
     end
     
     def registration_phase
       options[:registration_path] = nil
       redirect '/'
     end
   end

end
  
  
Rails.application.config.middleware.use OmniAuth::Builder do
 # provider :twitter, TWITTER_CONSUMER_KEY, TWITTER_CONSUMER_SECRET
 # provider :facebook, FACEBOOK_APP_ID, FACEBOOK_APP_SECRET, :iframe => true, :scope => 'email, user_about_me,
 #                 user_activities,user_birthday,user_education_history,
 #                 user_likes, user_location,
 #                 publish_stream, friends_about_me' #, friends_birthday'

 # provider :github, GITHUB_CLIENT_ID, GITHUB_SECRET, scope: "repo" #not sure why something like "user,repo" is failing, url stuff
 provider :identity, :fields => [:name], :on_register => SessionsController.action(:not_today)
 
 # provider :identity,
 #   :fields => [:nickname],
 #   :locate_conditions => lambda { |req| { model.auth_key => req['nickname']} },
 #   :on_login => SessionController.action(:login),
 #   :on_register => SessionController.action(:register),
 #   :on_failed_registration => SessionController.action(:failure)
 
end

  
