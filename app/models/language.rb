class Language < ActiveRecord::Base
  has_many :pastes
  before_save :update_count

  def update_count
    self.pastes_count = self.pastes.count
  end

  named_scope :top_languages, :limit => 10, :order => 'pastes_count desc'

end
