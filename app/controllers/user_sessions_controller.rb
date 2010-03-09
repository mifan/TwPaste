class UserSessionsController < ApplicationController
  before_filter :require_user, :only => :destroy

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default login_url
  end

end

