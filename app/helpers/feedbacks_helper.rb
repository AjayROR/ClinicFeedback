module FeedbacksHelper

	def current_user_is_admin?
    admin_department = Department.find_by_name('Admin')
      return current_user.department_id == admin_department.id 
    end


     def isSameDepartment?(instance)
       return instance.department_id == current_user.department_id
     end
end
