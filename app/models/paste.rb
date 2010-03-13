require "lib/highlight"
class Paste < ActiveRecord::Base
  attr_protected :views_count, :comments_count
  attr_accessor :post_to_twitter

  belongs_to :language, :counter_cache => true
  belongs_to :user, :counter_cache => true
  acts_as_taggable_on :tags

  acts_as_views_count
  acts_as_commentable

  validates_presence_of :code
  validates_length_of   :title, :maximum => 60

  before_save :format_code 
  after_save :twitter_update



  def twitter_update
    if post_to_twitter == '1'
        self.user.twitter_update("new paste: #{self.id} #{self.title} " + ShortenUrl.bitly_url("http://twpaste.com/pastes/#{self.id}"))
    end
  end

 

  # before_filters
  def format_code
      self.size = self.code.length
      self.code_formatted = Highlight.format(self.code,self.language.slug)
      code_lines = self.code.gsub("\r\n","\n").split("\n")
      self.line_count = code_lines.length
      self.summary_formatted = Highlight.format_without_linenos(code_lines[0..5].join("\n"),self.language.slug)
  end


  # find method
  def self.find_page(page = 1)		
    conditions = ["private = ?",false]
    paginate :page => page,
             :per_page => 8,
             :conditions => conditions,
             :order => "id desc",
             :include => [:user,:language]
  end

end
