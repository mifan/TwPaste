class User < ActiveRecord::Base
  has_many :snippets	
  attr_protected :admin
  validates_presence_of :name,:login, :passwd, :email
  validates_uniqueness_of :login,:email
  validates_length_of :name, :within => 2..20
  validates_length_of :login, :within => 4..50
  validates_format_of :login, :with => /^[\w\d\-\_]+$/, :message => "格式不符合要求(字母、数字、-、_)"

  def self.encode(passwd)
    Digest::MD5.hexdigest("-D(*@#JKS@**&^@-#{passwd}")
  end

  # check login by login/email and passwd
  def self.check_login(login,passwd)
    find(:first, :conditions => ['(login = ? or email = ?) and passwd = ?',login, login, passwd])
  end

  def self.find_top_by_snippets_count(size = 10)
    paginate :page => 1, :per_page => size, :order => "snippets_count desc"
  end

end
