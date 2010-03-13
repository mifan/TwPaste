class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]

  def new
    @user = User.new
  end

 def create
  @user = User.new(params[:user])
  @user.save do |result| # LINE A
    if result
      redirect_back_or_default root_path
    else
      unless @user.oauth_token.nil?
        @user = User.find_by_oauth_token(@user.oauth_token)
        unless @user.nil?
	  @user.update_twitter_info
          UserSession.create(@user,true)
          redirect_back_or_default root_path
        else
          redirect_back_or_default root_path
        end
      else
        redirect_back_or_default root_path
      end
    end
  end
end

end
