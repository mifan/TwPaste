class CommentObserver < ActiveRecord::Observer
  include ActionView::ERB::Util
  include ActionView::Helpers::TextHelper
  def after_create(comment)
    snippet = comment.commentable
    if snippet
      if snippet.user_id != comment.user_id
         replied_name = snippet.user.login
	 comment_user = comment.user
	 reply_url = "http://www.twpaste.com/code/#{snippet.id}"
	 reply_tweet = "@#{replied_name} #{h(comment.comment)}"
	 remind_length = 130 - reply_url.length
	 comment_user.twitter_update(truncate("#{reply_tweet} #{reply_url}",:length => remind_length))
      end
    end
  end
end
