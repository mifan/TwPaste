module LanguagesHelper
  @@languages = Language.all(:order => 'name ASC').map { |l| [l.name, l.id] }
  def languages_array
    @@languages
  end
end
