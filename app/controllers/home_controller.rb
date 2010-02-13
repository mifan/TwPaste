class HomeController < ApplicationController
	before_filter :require_login, :only => [:settings]
	
	
	# login
  def login
    @user = User.new
    
    if params[:user]
        @user = User.check_login(params[:user][:email], User.encode(params[:user][:passwd]))
        if @user
          save_login(@user)
          redirect_to "/"
          return
        else
          @user = User.new
          flash[:errors] = "Invalid login name/email or password."
        end
    end
    
		set_seo_meta("Login")
    render :action => "login"
  end
	
	def logout
		clear_login
		redirect_to "/"
	end
	
	def settings
		@user = @current_user		
		if request.method == :put
			p = params[:user]
			p[:admin] = @user.admin
			if @user.update_attributes(p)
        save_notice('User was successfully updated.')
        redirect_to :controller => "home", :action => "settings"
      else
        render :action => "settings"
      end
		end
	end
	
	

	def help
		set_seo_meta("Help")
	end
  
  def links
    set_seo_meta("Links")
  end
end
