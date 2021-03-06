class UserSessionsController < ApplicationController

  before_filter :require_user, :only => :destroy

  def destroy
    current_user_session.destroy
    redirect_back_or_default root_url
  end

end
