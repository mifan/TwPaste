class UserSession < Authlogic::Session::Base

def self.oauth_consumer
    OAuth::Consumer.new("IlWs2yGnF37alfsW2w", "ItMhbGjZQzn0tT00zudDEXtHg9aVuAO51IjsJmat8s",
    { :site=>"http://twitter.com",
      :authorize_url => "http://twitter.com/oauth/authorize" })
end

end