class Language < ActiveRecord::Base
  has_many :pastes
  before_save :before_save

  def before_save
    self.pastes_count = self.pastes.count
  end

  def self.find_top(size = 10)
    paginate(:page => 1,:per_page => size,:order => "pastes_count desc")
  end
end
