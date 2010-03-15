class PastesController < ApplicationController
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
      set_seo_meta("pastes &raquo; #{@language.name} language")
    elsif params[:user_id] && (@user = User.find_by_login(params[:user_id]))
        @pastes = @user.pastes.user_scoped(current_user).order('id DESC').find_page(params[:page])
        @sub_title = "Listing #{@user.login}'s pastes"
        @rss_url = rss_user_pastes_path(params[:user_id])
        set_seo_meta("#{@user.login}'s pastes")
    elsif params[:tag_id]
      @pastes = Paste.tagged_with(params[:tag_id],:on => :tags).user_scoped(current_user).order('id DESC').find_page(params[:page])
      #@pastes_count = Paste.tagged_with(params[:tag],:on => :tags).count(:select => "*")
      @sub_title = "Listing #{params[:tag_id]} pastes"
      @rss_url = rss_tag_pastes_path(params[:tag_id])
      set_seo_meta("pastes &raquo; Taged #{params[:tag_id]}")
    else
      @pastes = Paste.user_scoped(current_user).order('id DESC').find_page(params[:page])
      @sub_title = "Listing pastes"
      @feed_title = "Recent pastes"
      @rss_url = rss_pastes_path
      set_seo_meta("All pastes")
      
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
    set_seo_meta("##{@paste.id} #{@paste.title}")
    respond_to do |format|
      format.html # show.html.erb
      format.raw { render :text => @paste.code }
      format.code { render :text => @paste.code_formatted }
    end

  end


  def new
    @paste = Paste.new(:language_id => 6)
    set_seo_meta("New paste")
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

    set_seo_meta("New paste")
    render :action => 'new'
  end

  # GET /pastes/1/edit
  def edit
    @paste = current_user.pastes.find(params[:id])
    @paste.tag_list = @paste.tags.join(",")
    set_seo_meta("Edit paste")
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


