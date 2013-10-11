class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper
  helper :all

 #rescue_from ActiveRecord::RecordNotFound, :with => :routing_error
  before_filter :set_cache_buster

  before_filter :global_user

#  helper_method :current_user_is_admin?

def global_user
   Comment.user = current_user
  end
 
    #  rescue_from  Exception, :with => :routing_error
 
      # def routing_error
      #      flash[:error] = 'Invalid URL Access'
      #     redirect_to  current_user ? current_user : root_path
      # end


  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
  protected

  def check_session
    redirect_to root_path unless current_user
  end

  def should_not_loggedin
  	redirect_to current_user if current_user
  end

end