class CommentsController < ApplicationController
 def create

 
      pcomment = params[:comment]
      title = (pcomment[:title].blank?)?'Anonymous':pcomment[:title]
      @comment = @paste.comments.new(:title => title,:user => current_user,:comment => pcomment[:comment])       

        if @comment.save
          redirect_to :controller => :pastes, :action => :show,:id => params[:id],:anchor => "comments"
        else
          render :action => "show",:archor => "comments"
        end     
     
 end

end
