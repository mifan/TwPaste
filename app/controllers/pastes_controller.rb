class PastesController < ApplicationController
  # GET /pastes
  # GET /pastes.xml
  before_filter :require_user, :only => [:new,:create,:edit,:update,:destroy]

  
  def index 
    @sub_title = ''
    @pastes_count = 0
    if params[:language_id] && (@language = Language.find_by_slug(params[:language_id]))
      @pastes = @language.pastes.user_scoped(current_user).order('id DESC').find_page(params[:page])
      @sub_title = "Listing pastes in #{@language.name} language"
      @feed_title = "#{@language.name}"
      set_seo_meta("pastes &raquo; #{@language.name} language")
    elsif params[:user_id] && (@user = User.find_by_login(params[:user_id]))
        @pastes = @user.pastes.user_scoped(current_user).order('id DESC').find_page(params[:page])
        @sub_title = "Listing #{@user.login}'s pastes"
        @feed_title = "#{@user.login}'s pastes"
        set_seo_meta("#{@user.login}'s pastes")
    elsif params[:tag_id]
      @pastes = Paste.tagged_with(params[:tag_id],:on => :tags).user_scoped(current_user).order('id DESC').find_page(params[:page])
      #@pastes_count = Paste.tagged_with(params[:tag],:on => :tags).count(:select => "*")
      @sub_title = "Listing #{params[:tag_id]} pastes"
      @feed_title = "Tags: #{params[:tag_id]}"
      set_seo_meta("pastes &raquo; Taged #{params[:tag_id]}")
    else
      @pastes = Paste.user_scoped(current_user).order('id DESC').find_page(params[:page])
      @sub_title = "Listing pastes"
      @feed_title = "Recent pastes"
      set_seo_meta("All pastes")
    end

    @pastes_count = @pastes.total_entries

    if params[:type] == "feed"
      # Set the content type to the standard one for RSS
      response.headers['Content-Type'] = 'application/rss+xml'
        render "rss" , :layout => false
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @pastes }
      end
    end
  end

  # GET /pastes/1
  # GET /pastes/1.xml
  def show

    @paste = Paste.find(params[:id],:include => [:user,:tags,:comments])
    @paste.update_views_count
            
    if (@paste.private? && require_user && (current_user.id != @paste.user_id) )
       redirect_to root_url,:status=>:found
       return
    end

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

  # GET /pastes/1/edit
  def edit
    @paste = current_user.pastes.find(params[:id])
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


