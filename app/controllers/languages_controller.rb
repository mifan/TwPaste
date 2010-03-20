class LanguagesController < ApplicationController
  before_filter :admin_user, :only => [:new, :create, :edit, :update]

  def index
    @languages = Language.all(:order => 'name ASC')
   end

  def show
    @language = Language.find(params[:id])
  end

  def new
    @language = Language.new
  end

  def edit
    @language = Language.find(params[:id])
  end

  def create
    @language = Language.new(params[:language])
    if @language.save
      redirect_to(@language)
    else
      render :action => "new"
    end
  end


  def update
    @language = Language.find(params[:id])
      if @language.update_attributes(params[:language])
        redirect_to(@language)
      else
        render :action => "edit"
      end
  end

  def destroy
    @language = Language.find(params[:id])
    @language.destroy
    redirect_to(languages_url)
  end

end
