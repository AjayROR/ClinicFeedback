class FeedbacksController < ApplicationController
  def new
	@feedback = Feedback.new
  end
  
  def create
  	@feedback = Feedback.create(params[:feedback])
  	if @feedback.save 

      SendMail.send_patient(@feedback)
      #SendMail.send_patient(@feedback)
      #SendMail.delay.send_mail(@feedback)
      SendMail.feedback_submitted(@feedback).deliver
  		redirect_to  thankyou_path, :notice => 'feedback form submitted successfully!'
  	else
  		render 'new'
  	end
  end

  def show
    	@feedback  = Feedback.find(params[:id])
      
      respond_to do |format|
        format.html #show.html.erb
        format.js #show.js.erb
      end
  end
 
#  def index  this code has been modified to support data_table 
# #      @admin = current_user_is_admin

#        #@custom_list = Feedback.valid_feedback_list(current_user)
#        #@feedbacks = @custom_list.paginate(:page => params[:page], :per_page => 20, :order => 'created_at DESC')
#      if current_user_is_admin?
#       @feedbacks = Feedback.paginate(:page => params[:page], :per_page => 8, :order => 'created_at DESC')
#      else
#         @list_all = Feedback.where('feedbacks.department_id = ?', current_user.department_id)
#         @feedbacks = @list_all.paginate(:page => params[:page], :per_page => 8, :order => 'created_at DESC')
#         puts  '_______________________________________lolasdfasdfhkj____________________________'
#      end
    
#   end

def index

   
      @feedbacks = Feedback.all
   #@feedbacks = Feedback.find_each(batch_size: 30)
    
            # if current_user_is_admin?
            #   @feedbacks =  Feedback.all
            # else
            #   @feedbacks = Feedback.where('feedbacks.department_id=?',current_user.department_id)
            # end
           respond_to do |format|
               format.html #index.html.erb
              format.json { render json: @feedbacks }
       end
  end


# def index
# @list_all = current_user_is_admin?  ? Feedback.all : Feedback.where('feedbacks.department_id = ?', current_user.department_id)
# @feedbacks = @list_all.paginate(:page => params[:page], :per_page => 10, :order => 'created_at DESC')
# end
  def search_feedback
           # @result_feedback = Feedback.find_by_token(params[:token_no]) #61153892 
           # logger.info("in find_token")
           # @result_feedback = Feedback.last
           # #@feedback = Feedback.last
           # redirect_to feedbackresult_path

           if params[:token_no]
            @result_feedback = Feedback.find_by_token(params[:token_no])
           end
  end

end

# 70886869
# 12006270
# 32324071
# 26175272
# 75446373
# 20628074
# 68405275
# 88758076
# 38275877
# 82470678
# 65717579
# 17215180
# 40780881
# 76590082
# 82485883
# 40672284
# 16607285
# 88063786
# 30114687
# 42510188
# 25033189
# 65966790
# 74723791