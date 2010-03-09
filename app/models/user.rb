class User < ActiveRecord::Base
  has_many :pastes

  acts_as_authentic
  before_create :populate_oauth_user


 
  def update_twitter_info
    populate_oauth_user
  end

  def twitter_update(tweet) 
    client = TwitterOAuth::Client.new(
      :consumer_key => 'KvvYJRTQrGiHbUWlw4lXIg',
      :consumer_secret => 'AaxExL83gKvh7kGWQezNEWsr6x7klBw4Sc8EZCl4EUU',
      :token => self.oauth_token, 
      :secret => self.oauth_secret)
    if client.authorized?
      client.update(tweet)
    end
  end



 


  def oauth_json_info
     unless oauth_token.blank?
      @response = UserSession.oauth_consumer.request(:get, '/account/verify_credentials.json',
      access_token, { :scheme => :query_string })
      case @response
      when Net::HTTPSuccess
        user_info = JSON.parse(@response.body)
        return user_info
      end
    end
   end

  
 

  def populate_oauth_user
    unless oauth_token.blank?
      @response = UserSession.oauth_consumer.request(:get, '/account/verify_credentials.json',
      access_token, { :scheme => :query_string })
      case @response
      when Net::HTTPSuccess
        user_info = JSON.parse(@response.body)
        self.name = user_info['name']
        self.login = user_info['screen_name']
        self.twitter_uid = user_info['id']
        self.avatar_url = user_info['profile_image_url']
      end
    end
  end

end
