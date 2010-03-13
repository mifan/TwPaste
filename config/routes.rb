ActionController::Routing::Routes.draw do |map|

  map.resource :user_sessions, :only => [:destory]

  map.resources :pastes do |paste|
    paste.resources :comments,:only => [:create]
  end

  #language_id = languge.slug
  map.resources :languages do |language| 
     language.resources :pastes , :only =>[:index]
  end

  #user_id = user.login
  map.resources :users, :only => [:new,:create] do |user| 
    user.resources :pastes, :only =>[:index]
  end

  #tag_id = tag.name
  map.resources :tags, :only => [:show] do |tag|
    tag.resources :pastes, :only =>[:index]
  end


  map.login 'login', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'



  #map.feed "feed",:controller => "pastes", :action => "index",:type => "feed"
  #map.lang_feed "lang/:lang/feed",:controller => "pastes", :action => "index",:type => "feed"
  #map.user_feed ":login/feed",:controller => "pastes", :action => "index",:type => "feed"
 

  map.root :controller => 'pastes'

end
