require "md5"
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include Twitter::Autolink
  # return the formatted flash[:notice] html
  def success_messages
    if flash[:notice]
      '
      <div id="successMessage" class="successMessage">
    		'+flash[:notice]+'
    	</div>
      '
    else
      ''
    end
  end

  # form auth token
  def auth_token
    "<input name=\"authenticity_token\" type=\"hidden\" value=\"#{form_authenticity_token}\" />"
  end



  # format comment text

  def format_comment(comment)
    return  auto_link(simple_format(html_escape(comment)),:username_class => 'normal-weight')
  end

  def format_description(desc)
    return auto_link(simple_format(desc),:username_class => 'normal-weight')
  end

  #-------------------------------------------------------------
  def page_title
    (@page_title || '') << '&raquo; TwPaste &raquo; Twitter Paste &raquo; Code Sharing'
  end
  
  def page_keywords    
    (@page_keywords || '') <<  ' TwPaste Twitter Paste Code Sharing'
  end
    
  def page_description
    (@page_description || '') << ' TwPaste Twitter Paste Code Sharing'
  end

end
