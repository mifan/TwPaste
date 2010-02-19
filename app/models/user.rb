class User < ActiveRecord::Base
  has_many :snippets

  acts_as_authentic
  before_create :populate_oauth_user


  #TODO 
  def self.find_top_by_snippets_count(size = 10)
    paginate :page => 1, :per_page => size, :order => "snippets_count desc"
  end

  def update_twitter_info
    populate_oauth_user
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
