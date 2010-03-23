class PastesController < ApplicationController
  include SystemText
  # GET /pastes
  # GET /pastes.xml
  before_filter :require_user, :only => [:new,:create,:edit,:update,:destroy,:repaste]


  
  def index 
    @sub_title = ''
    @pastes_count = 0
    if params[:language_id] && (@language = Language.find_by_slug(params[:language_id]))
      @pastes = @language.pastes.user_scoped(current_user).order('id DESC').find_page(params[:page])
      @sub_title = "Listing pastes in #{@language.name} language"
      @rss_url = rss_language_pastes_path(params[:language_id])
      @page_title = "Pastes in #{@language.name} language - Page #{params[:page] || 1} "
      @page_keywords = "#{@language.name} Lanauage pastes "
      @page_description = "All pastes of Lanauage #{@language.name} "
    elsif params[:user_id] && (@user = User.find_by_login(params[:user_id]))
        @pastes = @user.pastes.user_scoped(current_user).order('id DESC').find_page(params[:page])
        @sub_title = "Listing #{@user.login}'s pastes"
        @rss_url = rss_user_pastes_path(params[:user_id])
        @page_title = "#{@user.login}'s pastes - Page #{params[:page] || 1} "
        @page_keywords = "#{@user.login} pastes "
        @page_description = "All pastes of user #{@user.login} "
    elsif params[:tag_id]
      @pastes = Paste.tagged_with(params[:tag_id],:on => :tags).user_scoped(current_user).order('id DESC').find_page(params[:page])
      #@pastes_count = Paste.tagged_with(params[:tag],:on => :tags).count(:select => "*")
      @sub_title = "Listing pastes  tagged with #{params[:tag_id]}"
      @rss_url = rss_tag_pastes_path(params[:tag_id])
      @page_title = "Pastes tagged with #{params[:tag_id]} - Page #{params[:page] || 1} "
      @page_keywords = "#{params[:tag_id]} pastes "
      @page_description = "All pastes tagged with #{params[:tag_id]} "
    else
      @pastes = Paste.user_scoped(current_user).order('id DESC').find_page(params[:page])
      @sub_title = "Listing pastes"
      @rss_url = rss_pastes_path
      @page_title = "All pastes - Page #{params[:page] || 1} "
      @page_keywords = "All pastes language"
      @page_description = "All pastes ,All Language ,All Users "
      
    end
    @pastes_count = @pastes.total_entries
    @tags = Paste.user_scoped(current_user).tag_counts_on(:tags)
  end


  def rss
    @rss_title = ''
    @rss_link = ''
    if params[:language_id] && (@language = Language.find_by_slug(params[:language_id]))
      @pastes = @language.pastes.feed_only
      @rss_title = "Pastes in #{@language.name} language"
      @rss_link = language_pastes_path(params[:language_id])
    elsif params[:user_id] && (@user = User.find_by_login(params[:user_id]))
        @pastes = @user.pastes.feed_only
	@rss_title = "#{@user.login}'s pastes"
        @rss_link = user_pastes_path(params[:user_id])
    elsif params[:tag_id]
      @pastes = Paste.tagged_with(params[:tag_id],:on => :tags).feed_only
      @rss_title = "Tags: #{params[:tag_id]}"
      @rss_link = tag_pastes_path(params[:tag_id])
    else
      @pastes = Paste.feed_only
      @rss_title = "Recent pastes"
      @rss_url = pastes_path
      
    end
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end



  # GET /pastes/1
  # GET /pastes/1.xml
  def show
    @paste = Paste.find(params[:id],:include => [:user,:tags,:comments])
    if (@paste && @paste.private? && (current_user.id != @paste.user_id) )
       redirect_to root_url,:status=>:found
       return
    end
    @paste.update_views_count
    @comment = @paste.comments.new

      @page_title = "#{@paste.title || 'Untitled'} - Paste ID ##{@paste.id} "
      @page_keywords = "#{@paste.tags.join(' ')} TwPaste #{@paste.title}"
      @page_description = meta_description_text(@paste.desc)
    respond_to do |format|
      format.html # show.html.erb
      format.raw { render :text => @paste.code }
      format.code { render :text => @paste.code_formatted }
    end

  end


  def new
    @paste = Paste.new(:language_id => 35)
    @page_title = "New paste " 
  end

  def repaste
    paste_origin = Paste.find(params[:id])
    if (paste_origin && paste_origin.private? && (current_user.id != paste_origin.user_id) )
       redirect_to root_url,:status=>:found
       return
    end
    @paste = Paste.new do |pa|
      pa.title = paste_origin.title
      pa.code = paste_origin.code
      pa.desc = paste_origin.desc
      pa.private = paste_origin.private
      pa.language_id = paste_origin.language_id
      pa.tag_list = paste_origin.tags.join(",")
    end

    @page_title = "Repaste "
    render :action => 'new'
  end

  # GET /pastes/1/edit
  def edit
    @paste = current_user.pastes.find(params[:id])
    @paste.tag_list = @paste.tags.join(",")
    @page_title = "Edit paste " 
  end

  # POST /pastes
  # POST /pastes.xml
  def create
    @paste = current_user.pastes.build(params[:paste])
    @paste.save!
    redirect_to(@paste)
  end

  # PUT /pastes/1
  # PUT /pastes/1.xml
  def update
    @paste = current_user.pastes.find(params[:id])
    @paste.update_attributes!(params[:paste])
    redirect_to(@paste)
  end

  # DELETE /pastes/1
  # DELETE /pastes/1.xml
  def destroy
    @paste = current_user.pastes.find(params[:id])
    @paste.destroy
    respond_to do |format|
      format.html { redirect_to(pastes_url) }
      format.xml  { head :ok }
    end
  end

end 


