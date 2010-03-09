class CommentObserver < ActiveRecord::Observer
  include ERB::Util
  include ActionView::Helpers::TextHelper
  def after_create(comment)
    paste = comment.commentable
    if paste
      if paste.user_id != comment.user_id
         replied_name = paste.user.login
	 comment_user = comment.user
	 reply_url = "http://twpaste.com/paste/#{paste.id}"
	 reply_tweet = "@#{replied_name} #{h(comment.comment)}"
	 remind_length = 130 - reply_url.length
	 comment_user.twitter_update(truncate("#{reply_tweet} #{reply_url}",:length => remind_length))
      end
    end
  end
end
