class PasteSweeper < ActionController::Caching::Sweeper
  observe Paste

  def after_update(paste)
    sweeper(paste)
  end

  def sweeper(paste)
    expire_fragment "pastes/index/*"
    expire_fragment "pastes/show/#{paste.id}.*"
  end
end
 
