class Feedback < ActiveRecord::Base 

attr_accessible :rating1, :rating2, :rating3, :rating4, 
                :rating5, :rating5a, :rating5b, :rating6,
                :department_id, :feedback, :name, :email, :average_raiting, :token

before_save :fill_average_raiting
before_save :generate_token
  
      has_many :comments
      belongs_to :department

      validates :name, :presence => true
      validates_presence_of :rating1, :rating2, :rating3, :rating4, :rating5, 
                          :rating5a, :rating5b, :rating6,:department_id, :feedback, 
                          :name, :email
    #   validates_presence_of :token
    #   validates_uniqueness_of :token
   
   def self.find_department_name(feedback)
    Department.find(feedback.department_id).name
   end

     def generate_token 
      self.token =  rand(99999).to_s.center(6,rand(9).to_s)+  '_'+  self.id.to_s
     end

     def fill_average_raiting
   	    @rating5 = self.rating5 == 'true' ? 1  : 0 
      self.average_raiting = (self.rating1  + self.rating2 + self.rating3 + self.rating4 + 
                           self.rating5a + self.rating5b  + self.rating6 + @rating5) 
     end


# def self.get_previous_feedback current_feedback
# Feedback.where("feedbacks.id < ?", current_feedback.id).order('created_at asc').last
# end

# def self.get_next_feedback current_feedback
# Feedback.where("feedbacks.id > ?", current_feedback.id).order('created_at asc').first
# end
 
 
  def self.get_previous_feedback(current_feedback,current_user)
  unless current_user.department_id == 3
   Feedback.where("feedbacks.id < ? AND feedbacks.department_id = ?", current_feedback.id, current_user.department_id).order('created_at asc').last
   else
     Feedback.where("feedbacks.id < ? ", current_feedback.id).order('created_at asc').last
  end
end

 def self.get_next_feedback(current_feedback,current_user)
      unless current_user.department_id == 3
      Feedback.where("feedbacks.id > ? AND feedbacks.department_id = ?", current_feedback.id, current_user.department_id).order('created_at asc').first
    else 
 Feedback.where("feedbacks.id > ? ", current_feedback.id).order('created_at asc').first
   end
  end








# def self.get_previous_feedback current_feedback
# Feedback.where( ("feedbacks.id < ?",current_feedback.id) AND
#  ("feedbacks.department_id = ?", current_user.department_id)).order('created_at asc').last
# end

# def self.get_next_feedback current_feedback
# Feedback.where(("feedbacks.id > ?",current_feedback.id)
#   AND ("feedbacks.department_id = ?", current_user.department_id )).order('created_at asc').first
# end

end 