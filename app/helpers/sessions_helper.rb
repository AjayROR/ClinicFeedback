module SessionsHelper
  
  def sign_in(user)
       cookies.permanent.signed[:remember_token] = [user.id, user.salt]
       current_user = user
  end

  def current_user=(user)
      @current_user =  user 
  end

  def current_user
      #@current_user #this line will change in future.
      #@current_user ||= user_from_remember_token
      @current_user = @current_user || user_from_remember_token
  end

  def user_from_remember_token
    User.authenticate_with_salt(*remember_token) #remember_token consists of id & salt
    #User.authenticate_with_salt (id, salt)
  end

  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    cookies.delete(:remember_token)
    current_user = nil
  end

  
  def current_user_is_admin?
    admin_department = Department.find_by_name('Admin')
      return current_user.department_id == admin_department.id 
    end

end