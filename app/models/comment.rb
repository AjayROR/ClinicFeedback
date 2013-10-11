class Comment < ActiveRecord::Base 
  attr_accessible :body, :commenter
  cattr_accessor :user
  belongs_to :feedback
  
#self.commenter = self.user.nil?  ? 'patient' : self.user.name

end