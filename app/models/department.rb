class Department < ActiveRecord::Base
  
  attr_accessible :name
  has_many :feedbacks, dependent: :destroy
  has_many :users, dependent: :destroy

  before_save :trim_name

  validates :name, :presence => true, :uniqueness => true

  def trim_name
  	#self.name = self.name.capitalize.delete(' ')
  	self.name = self.name.capitalize.strip
  end


def self.get_previous_department current_department
Department.where("departments.name < ?", current_department.name).order('name ASC').last
end

def self.get_next_department(current_department)
Department.where("departments.name > ?", current_department.name).order('name ASC').first
end

end





# Admin
# Blood
# Brain
# Cardiologist
# Dental
# Department2
# Department3
# Entdepartment
# Skin Disease
# Surgery
