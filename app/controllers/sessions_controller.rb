class SessionsController < ApplicationController
  before_filter :should_not_loggedin, :except => [:destroy]
     helper "errors"
  
  def new
    @title =  "Sign in"
    @user = User.new
  end


  def create
    user = User.authenticate( params[:session][:email], params[:session][:password])

     if user.nil?
      flash[:alert] = "Invalid  Username/Password Entered!!!"
      redirect_to root_path
      #render 'new'
     else
      #
      sign_in user
      SendMail.delay.user_login_mail(user)
      redirect_to user
     end
  end

  def destroy
        sign_out
        redirect_to root_path
  end
end