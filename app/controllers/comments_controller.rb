class CommentsController < ApplicationController
  

  	#before_filter :set_current_user
	# def add_user
	# 	current_user.name
	# end
	# 


	def create
 
   	    @feedback  =  Feedback.find(params[:feedback_id])
   	    @comment = @feedback.comments.create(params[:comment])
   	    
   	    @comment.commenter = current_user ? current_user.name : @feedback.name
   	    @comment.save
   	    #Comment.add_commenter current_user.name
   	   # SendMail.comment_mail_to_patient(@feedback, current_user).deliver
         respond_to do |format|
   	     format.html { redirect_to feedback_path(@feedback) }
           format.js
        end
end

end