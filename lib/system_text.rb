module SystemText
  # for controller using helper methods
  
  def meta_description_text(description)
    return '' if description.blank?
    st = SystemTextSingleton.instance
    text =  description
    text.gsub!(/<br/m, '')
    text.gsub!(/&[a-zA-Z]{2,6};/m,'')
    text.gsub!(/[<>]/m,'')
    text.gsub!(/[\r\n]/m,' ')
    st.truncate(text.strip,98,'')
  end
  
  def controller_html_escape(s)
     #bujiande_text = BuJianDeTextSingleton.instance
     #curr_text = bujiande_text.html_escape_1(s)
     s.gsub(/&[a-zA-Z]{2,6};/m,'')
  end
  
  def tags_to_keywords(tags)  
    return '' if tags.blank?
    tags.to_s .gsub(/ /, ',')    
  end
  
 
  
  class SystemTextSingleton
    require "erb"
    include Singleton
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::SanitizeHelper
    include ERB::Util
    def html_escape_1(s)
	html_escape(s)
    end
  end
  
end
