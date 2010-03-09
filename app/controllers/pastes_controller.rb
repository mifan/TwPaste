class PastesController < ApplicationController
  # GET /pastes
  # GET /pastes.xml
  before_filter :require_user, :only => [:create,:edit,:update,:destroy]
  
  def index 
    @sub_title = ""
    @pastes_count = 0
    if params[:lang]
      @language = Language.find_by_slug(params[:lang])
      if @language
        @pastes = @language.pastes.find_page(params[:page])
        @pastes_count = @language.pastes.count
        @sub_title = "Listing pastes in #{@language.name} language"
        @feed_title = "#{@language.name}"
        set_seo_meta("pastes &raquo; #{@language.name} language")
      end
    elsif params[:tag]          
      @pastes = paste.tagged_with(params[:tag],:on => :tags).find_page(params[:page])
      @pastes_count = paste.tagged_with(params[:tag],:on => :tags).count(:select => "*")
      @sub_title = "Listing #{params[:tag]} pastes"
      @feed_title = "#{params[:tag]}"
      set_seo_meta("pastes &raquo; Taged #{params[:tag]}")
    elsif params[:login]
      @user = User.find_by_login(params[:login])
      if @user
        @pastes = @user.pastes.find_page(params[:page])
        @pastes_count = @user.pastes_count
        @sub_title = "Listing #{@user.login}'s pastes"
        @feed_title = "#{@user.login}'s pastes"
        set_seo_meta("#{@user.login}'s pastes")
      end
    else
      @pastes = paste.find_page(params[:page])
      @pastes_count = paste.count
      @sub_title = "Listing pastes"
      @feed_title = "Recent pastes"
      set_seo_meta(nil)
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
    
    if request.post?
      pcomment = params[:comment]
      title = (pcomment[:title].blank?)?'Anonymous':pcomment[:title]
      @comment = @paste.comments.new(:title => title,:user => current_user,:comment => pcomment[:comment])       

        if @comment.save
          redirect_to :controller => :pastes, :action => :show,:id => params[:id],:anchor => "comments"
        else
          render :action => "show",:archor => "comments"
        end     
  
    else            
      @comment = @paste.comments.new
      set_seo_meta("##{@paste.id} #{@paste.title}")

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @paste }
        format.raw { render :text => @paste.code }
        format.code { render :text => @paste.code_formatted }
      end
    end
  end
    
  # GET /pastes/new
  # GET /pastes/new.xml
  def new
    @paste = paste.new
    set_seo_meta("New paste")
    respond_to do |format|
      format.html { render :action => "edit" } # new.html.erb
      format.xml  { render :xml => @paste }
    end
  end

  # GET /pastes/1/edit
  def edit
    @paste = paste.find(params[:id])
    set_seo_meta("Edit paste")
  end

  # POST /pastes
  # POST /pastes.xml
  def create
    @paste = paste.new(params[:paste])
    if @current_user
      @paste.user_id = @current_user.id
    else
      @paste.user_id = nil
    end
    
    if @paste.errors.size > 0
      render :action => "edit"
    else
      respond_to do |format|
        if @paste.save
          flash[:notice] = 'paste was successfully created.'
          format.html { redirect_to(@paste) }
          format.xml  { render :xml => @paste, :status => :created, :location => @paste }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @paste.errors, :status => :unprocessable_entity }
        end
      end
    end

    
  end

  # PUT /pastes/1
  # PUT /pastes/1.xml
  def update
    @paste = Paste.find(params[:id])
        
    respond_to do |format|
      if @paste.update_attributes(params[:paste])
        flash[:notice] = 'paste was successfully updated.'
        format.html { redirect_to(@paste) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @paste.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pastes/1
  # DELETE /pastes/1.xml
  def destroy
    @paste = Paste.find(params[:id])
    @paste.destroy

    respond_to do |format|
      format.html { redirect_to(pastes_url) }
      format.xml  { head :ok }
    end
  end
end
