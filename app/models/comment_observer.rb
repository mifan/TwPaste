class CommentObserver < ActiveRecord::Observer 
  def after_create(comment)
    snippet = comment.commentable
    if snippet
      if snippet.user_id != comment.user_id
         replied_name = snippet.user.login
	 comment_user = comment.user
	 reply_tweet = "@#{replied_name} #{comment.comment}"
	 comment_user.twitter_update(truncate(h(reply_tweet),:length => 130))
         #snippet.user.update("@#{comment.user.login} #{comment}")
      end
    end
  end
end
