class UsersController < ApplicationController
  before_filter :load
      before_filter :check_session, :only =>[:show, :doc_request]
     #before_filter :should_not_loggedin, :except => [:show]
   # private  
  # helper "errors"


  def load
          @user = User.new
          @users  = User.all
  end



  def show
    #@user = User.find(params[:id])
    @user = User.find_by_permalink(params[:id])
    @title = @user.name
  end

  def new
    @title = "Sign Up"
    redirect_to current_user if current_user
    @user = User.new
  end

  def create
     @user = User.create(params[:user])
     if @user.save 
     # sign_in @user
     # flash[:err] ='User created Successfully!'
      #redirect_to @user
      #SendMail.notifyAdmin(@user).deliver
      redirect_to root_path, :notice => 'Account Activation Pending!'
     else
      redirect_to root_path, :notice => 'All Fields Are Compulsory!'
       #render 'new'
     end
  end

=begin
  def update
   # @user = User.find(params[:id])
     @user = User.find_by_permalink(params[:id])
     if @user.update_attributes(params[:user]) 
      redirect_to @user, :notice => 'user profile updated Successfully'
      SendMail.delay.user_profile_updated(@user)
    else
        render 'edit'
      end
  end
=end

def edit
     #@user = User.find_by_permalink(params[:id])
     @user = User.find(params[:id])
      
  end


 def update
  #@user = User.find_by_permalink(params[:id])
  @user = User.find_by_id(params[:id])
  if @user.update_attributes(params[:user])
    flash[:notice] = ' Successfully updated'

    respond_to do |format|
          format.html #index.html.erb
          format.json { render json: @user}
        end
    
  end
  
end

def index
      #@validUsers = current_user_is_admin? ? User.all : User.where('users.department_id = ?',current_user.department_id)
      #@users = @validUsers.paginate(:page => params[:page], :per_page => 4, :order => 'created_at DESC')

      if current_user_is_admin?
    #  @users = User.paginate(:page => params[:page], :per_page => 10, :order => 'created_at DESC')
    @users =  User.all
     else
       # @list_all = User.where('users.department_id = ?', current_user.department_id)
       # @users = @list_all.paginate(:page => params[:page], :per_page => 10, :order => 'created_at DESC')
       @users = User.where('users.department_id = ?', current_user.department_id)
     end

        respond_to do |format|
          format.html #index.html.erb
          format.json { render json: @users}
        end
end
  
   def doc_request 
     @NewDoctors = User.new_joined_docs 

     @docs = @NewDoctors.paginate(:page => params[:page], :per_page => 8, :order => 'created_at ASC') 
    # puts '____________________-I am running absolutley fine________________________'
   end

    def activate_my_doctor
         @doc = User.find(params[:id])
         @activated = @doc.activate_doctor
         @doc.activate_new_doctor_account
         
         @NewDoctors = User.new_joined_docs
         @docs = @NewDoctors.paginate(:page => params[:page], :per_page => 8, :order => 'created_at ASC') 
        
         
         respond_to do |format|
            format.html {
            flash[:notice] = 'Doctor Account Activated Successfully'
                      redirect_to(new_doc_list_path) #, :notice => 'Doctor Added Successfully'
                    } 
            format.js
          end
          SendMail.doctor_activated(@doc).deliver  
        
      end


        def remove_doctor
         @doc = User.find(params[:id])
         @removed = @doc.remove_doctor
        redirect_to request_path, :notice => 'Doctor Removed Successfully'
        end

       def update_password
        #@user = User.find(params[:id])
        redirect_to root_path, :notice  => 'I am in right method'
       end
end