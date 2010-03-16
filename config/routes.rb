ActionController::Routing::Routes.draw do |map|

  map.resource :user_sessions, :only => [:destory]


  map.resources :pastes, :member => { :repaste => :get }, :collection => { :rss => :get } do |paste|
    paste.resources :comments,:only => [:create]
  end

  #language_id = languge.slug
  map.resources :languages do |language| 
     language.resources :pastes , :only =>[:index], :collection => { :rss => :get }
  end

  #user_id = user.login
  map.resources :users, :only => [:new,:create] do |user| 
    user.resources :pastes, :only =>[:index,:rss], :collection => { :rss => :get }
  end

  #tag_id = tag.name
  map.resources :tags, :only => [:show] do |tag|
    tag.resources :pastes, :only =>[:index], :collection => { :rss => :get }
  end

  map.login '/login', :controller => 'users', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'

  map.paste_show  "/:id", :controller => "pastes", :action => "show" ,:requirements => { :id => /\d+/ } 


  #map.feed "feed",:controller => "pastes", :action => "index",:type => "feed"
  #map.lang_feed "lang/:lang/feed",:controller => "pastes", :action => "index",:type => "feed"
  #map.user_feed ":login/feed",:controller => "pastes", :action => "index",:type => "feed"

  map.root :controller => 'pastes'

  map.connect '/pastes/pages/:page', :controller => 'pastes', :action => 'index', :requirements => { :page => /\d+/ } 
  map.connect '/users/:user_id/pastes/pages/:page', :controller => 'pastes', :action => 'index', :requirements => { :page => /\d+/ } 
  map.connect '/tags/:tag_id/pastes/pages/:page', :controller => 'pastes', :action => 'index', :requirements => { :page => /\d+/ } 
  map.connect '/languages/:language_id/pastes/pages/:page', :controller => 'pastes', :action => 'index', :requirements => { :page => /\d+/ } 

end
