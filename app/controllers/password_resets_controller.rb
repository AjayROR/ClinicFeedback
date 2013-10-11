class PasswordResetsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, :with => :link_expired

 def link_expired
    flash[:error] = 'Better Luck Next Time Sweety! Link has expired'
     redirect_to  current_user ? current_user : root_path
  end

  def new
  end

  def create
  	  user = User.find_by_email(params[:email])
      logger.info "Sent your Mail"
  	 
        if params[:name] == "time"
            user.send_password_reset 
            flash[:notice] = "password recovery information has been Emailed"
      
        elsif params[:name] == "graph"
          user.send_password_mobile
          flash[:notice] = "Passcode sent to Mobile"
        end
   
  	 
        respond_to do |format|
           format.html { redirect_to root_path }
           format.js
        end

          send_text_message
  end


  def send_text_message
    
  end

  
  def edit
  	if current_user  
        sign_out # calling the session helper method to set the current_user & session to nil
        flash[:notice] = 'Logged in user has been signed out!'
        redirect_to edit_password_reset_path
    else
     	@user = User.find_by_password_reset_token!(params[:id])
    end
  end

  def update
     @user = User.find_by_password_reset_token!(params[:id])

        if @user.password_reset_sent_at <  2.hours.ago
            redirect_to new_password_reset_path, :alert => "Password Reset Link has Expired"
        elsif @user.update_attributes(params[:user])
        	  @user.remove_old_password_reset_token

        	  redirect_to root_url, :notice =>  "Password has been updated successfully"
          else
        	render 'edit', :notice  => 'Link Expired'
        end 
    end
  
end