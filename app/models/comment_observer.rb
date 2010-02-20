class CommentObserver < ActiveRecord::Observer 
  def after_create(comment)
    snippet = comment.commentable
    if snippet
      if snippet.user_id != comment.user_id
         #snippet.user.update("@#{comment.user.login} #{comment}")
      end
    end
  end
end
