class PastesController < ApplicationController
  # GET /pastes
  # GET /pastes.xml
  before_filter :require_user, :only => [:new,:create,:edit,:update,:destroy]

  
  def index 
    @sub_title = ''
    @pastes_count = 0
    if params[:language_id] && (@language = Language.find_by_slug(params[:language_id]))
      @pastes = @language.pastes.find_page(params[:page])
      @pastes_count = @language.pastes.count
      @sub_title = "Listing pastes in #{@language.name} language"
      @feed_title = "#{@language.name}"
      set_seo_meta("pastes &raquo; #{@language.name} language")
    elsif params[:user_id] && (@user = User.find_by_login(params[:user_id]))
        @pastes = @user.pastes.find_page(params[:page])
        @pastes_count = @user.pastes_count
        @sub_title = "Listing #{@user.login}'s pastes"
        @feed_title = "#{@user.login}'s pastes"
        set_seo_meta("#{@user.login}'s pastes")
    elsif params[:tag_id]
      @pastes = Paste.tagged_with(params[:tag_id],:on => :tags).find_page(params[:page])
      @pastes_count = Paste.tagged_with(params[:tag],:on => :tags).count(:select => "*")
      @sub_title = "Listing #{params[:tag_id]} pastes"
      @feed_title = "Tags: #{params[:tag_id]}"
      set_seo_meta("pastes &raquo; Taged #{params[:tag_id]}")
    else
      @pastes = Paste.find_page(params[:page])
      @pastes_count = Paste.count
      @sub_title = "Listing pastes"
      @feed_title = "Recent pastes"
      set_seo_meta("All pastes")
    end

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
            
    if @paste.private
      return if not require_user
      if not(@current_user.id == @paste.user_id or @current_user.admin)
        render_404
        return
      end
    end

      @comment = @paste.comments.new
      set_seo_meta("##{@paste.id} #{@paste.title}")
      respond_to do |format|
        format.html # show.html.erb
        format.raw { render :text => @paste.code }
        format.code { render :text => @paste.code_formatted }
      end

  end
    
  # GET /pastes/new
  # GET /pastes/new.xml
  def new
    @paste = Paste.new
    set_seo_meta("New paste")
    respond_to do |format|
      format.html { render :action => "edit" } # new.html.erb
      format.xml  { render :xml => @paste }
    end
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
    flash[:notice] = 'paste was successfully created.'
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


