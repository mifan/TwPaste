class Language < ActiveRecord::Base
  has_many :pastes
  before_save :update_paste_counter
  def update_paste_counter
    #self.pastes_count = self.pastes.count
  end

  named_scope :top_languages, :limit => 10, :order => 'pastes_count desc'

end
