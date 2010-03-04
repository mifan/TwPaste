require "lib/highlight"
require "lib/string"
class Snippet < ActiveRecord::Base
  attr_protected :views_count, :comments_count
  belongs_to :language, :counter_cache => true
  belongs_to :user, :counter_cache => true
  acts_as_taggable_on :tags

  acts_as_views_count
  acts_as_commentable

  validates_presence_of :code
  validates_length_of   :title, :within => 2..50

  before_save :format_code 
  after_create :twitter_update


  def skip_before_filter
    return @skip_before_filter
  end


  def twitter_update
    self.user.twitter_update("Create a new snippet: #{self.id} #{self.title} , http://www.twpaste.com/code/#{self.id}")
  end

  def skip_before_filter=(skip_before_filter)
    @skip_before_filter = skip_before_filter
  end

  # before_filters
  def format_code
    if not self.skip_before_filter
      self.size = self.code.length
      self.code_formatted = Highlight.format(self.code,self.language.slug)
      code_lines = self.code.gsub("\r\n","\n").split("\n")
      self.line_count = code_lines.length
      self.summary_formatted = Highlight.format(code_lines[0..5].join("\n"),self.language.slug)
    end
  end

  def size_kb
    f = sprintf("%0.2f",self.size / 1024)
    return "#{f} KB"
  end

  def code_formatted_show
    if code_formatted.index('<table class="highlighttable">')
      code_formatted.gsub('<div class="highlight">','<div class="inner_code">')
    end
    return code_formatted.gsub('<table class="highlighttable">',
        '<div class="highlight_top">View: <a href="#">Source</a> or <a href="#{APP_DOMAIN}/code/#{self.id}.raw" target="_blank">Raw</a></div><table class="highlight" cellspacing="0" cellpadding="0">')
  end

  def summary_formatted_show
    return summary_formatted.gsub('<table class="highlighttable">','<table class="highlight">')
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
