require "lib/shorten_url"
class Comment < ActiveRecord::Base
  attr_accessor :post_to_twitter

  include ActsAsCommentable::Comment
	
  belongs_to :commentable, :polymorphic => true, :counter_cache => true
  validates_presence_of :comment 
	
  default_scope :order => 'id ASC'
	
  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user, :counter_cache => true

  after_create :twitter_update



  def twitter_update
    if post_to_twitter == '1'
        self.user.twitter_update("#{self.comment} " + ShortenUrl.bitly_url("http://twpaste.com/pastes/#{self.commentable.id}") ) 
    end
  end


end
