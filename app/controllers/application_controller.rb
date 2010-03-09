class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user_session, :current_user , :admin_user
  filter_parameter_logging :password, :password_confirmation

  # 输出404错误
  def render_404
    render_optional_error_file(404)
  end
  
  # 设置SEO 的Meta 值
  def set_seo_meta(title,keywords = '',desc = '')
    if title
      @page_title =  "#{title} &raquo; TwPaste"
    else
      @page_title = "TwPaste"
    end
    @meta_keywords = keywords
    @meta_description = desc
  end

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_url
        return false
      end
    end

    def admin_user
      if current_user
           return true if ['twpaste','twpastest','mifan'].include? current_user.login
      end
      false
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end




  

end
