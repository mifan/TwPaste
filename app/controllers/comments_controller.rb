class CommentsController < ApplicationController

  def create
      paste = Paste.find_by_id(params[:paste_id])
      @comment = paste.comments.build(:user => current_user,:comment => params[:comment])
      @comment.save
      respond_to do |format|
          render :partial => 'pastes/comment' if request.xhr?
          format.html { redirect_to :back }
      end
  end

end
