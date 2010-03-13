module PastesHelper

  def has_permission(paste)
    if current_user
      if current_user.id == paste.user_id
        return true
      end
    end
    return false
  end

  def paste_title(paste)
       title = paste.title.blank? ? 'View' : paste.title 
       truncate(h(title),:length => 50)
  end
end
