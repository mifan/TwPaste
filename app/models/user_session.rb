class UserSession < Authlogic::Session::Base

def self.oauth_consumer
    OAuth::Consumer.new("KvvYJRTQrGiHbUWlw4lXIg", "AaxExL83gKvh7kGWQezNEWsr6x7klBw4Sc8EZCl4EUU",
    { :site=>"http://twitter.com",
      :authorize_url => "http://twitter.com/oauth/authorize" })
end

end