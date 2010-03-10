require "lib/highlight"
require "lib/string"
class Paste < ActiveRecord::Base
  attr_protected :views_count, :comments_count

  belongs_to :language, :counter_cache => true
  belongs_to :user, :counter_cache => true
  acts_as_taggable_on :tags

  acts_as_views_count
  acts_as_commentable

  validates_presence_of :code
  validates_length_of   :title, :maximum => 60

  before_save :format_code 
  after_create :twitter_update


  named_scope :matching, lambda { |column, value|
    return {} if value.blank?
    { :conditions => ["#{column} = ?", "%#{value}%"] }
  }

  named_scope :order , :order => 'id DESC' 

  named_scope :language , lambda { |language_id|
    { :conditions => ["language_id = ?", language_id] }
  }

  named_scope :public, :conditions => {:private => false } 


  def twitter_update
    self.user.twitter_update("new paste: #{self.id} #{self.title} , http://twpaste.com/pastes/#{self.id}")
  end

 

  # before_filters
  def format_code
      self.size = self.code.length
      self.code_formatted = Highlight.format(self.code,self.language.slug)
      code_lines = self.code.gsub("\r\n","\n").split("\n")
      self.line_count = code_lines.length
      self.summary_formatted = Highlight.format_without_linenos(code_lines[0..5].join("\n"),self.language.slug)
  end

  def size_kb
    f = sprintf("%0.2f",self.size / 1024)
    return "#{f} KB"
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
