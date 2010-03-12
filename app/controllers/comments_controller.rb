class CommentsController < ApplicationController

  def create
      paste = Paste.find_by_id(params[:paste_id])
      @comment = paste.comments.build(params[:comment])
      @comment.user = current_user
      @comment.save!
      respond_to do |format|
          render :partial => 'pastes/comment' if request.xhr?
          format.html { redirect_to :back }
      end
  end

end
