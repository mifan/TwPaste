ActionController::Routing::Routes.draw do |map|

  map.resource :user_session, :only => [:destory]

  map.resources :pastes do |paste|
    paste.resources :comments
  end

  #language_id = languge.slug
  map.resources :languages do |language| 
     language.resources :pastes 
  end

  #user_id = user.login
  map.resources :users, :only => [:new,:create,:show] do |user| 
    user.resources :pastes 
  end

  #tag_id = tag.name
  map.resources :tags, :only => [:show] do |tag|
    tag.resources :pastes
  end

  map.connect "pastes/:id/comment",:controller => "pastes", :action => "show" ,:only => :post

  map.login 'login', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'user_session', :action => 'destroy'



  map.feed "feed",:controller => "pastes", :action => "index",:type => "feed"
  map.lang_feed "lang/:lang/feed",:controller => "pastes", :action => "index",:type => "feed"
  map.user_feed ":login/feed",:controller => "pastes", :action => "index",:type => "feed"
 

  map.root :controller => 'pastes'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
