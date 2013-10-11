require 'digest'
require 'mechanize'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :email, :name, :password, :password_confirmation, :department_id,
  :password_reset_token, :password_reset_sent_at, :mobile_no #, :password_new, :password_confirmation
  
  before_save :create_paramlink
  before_save :encrypt_password
 
  belongs_to :department

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  :presence => true,
                    :length => { :minimum => 4 }

  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
 
 validates :password, length: {minimum: 8, allow_blank: true },  
                 confirmation: true

 # validates :password_new, :presence => true, confirmation: true
 # validates :password_confirmation, :presence => true


def self.pending_doc_count
User.where('active = 0').count.to_s
end


def manual_reset_password
    puts 'Bing is here'
    #self.encrypted_password = encrypt("mindfire")
    string = "amitpanda"
    self.encrypted_password = secure_hash("#{self.salt}--#{string}")
    save! 
    
   end

def self.new_joined_docs
  User.where("users.active = ?", 0).order('created_at asc')
   #User.where("users.active = ?", 0).pluck(:email)
end

def  activate_doctor
 #registered_user = User.where("users.active = ?", 0).first
  #registered_user.active = 1
   #registered_user.save!
   self.active = 1
   # self.password = encrypt('mindfire')
   # self.password_confirmation = encrypt('mindfire')
   save!
end

def remove_doctor
  self.destroy
  save!
end


 def activate_new_doctor_account
  self.password_reset_token = encrypt(:email)
  self.password_reset_sent_at = Time.zone.now
  save!
  
 end

 def send_password_reset
 
  self.password_reset_token = encrypt(:email)
  self.password_reset_sent_at = Time.zone.now
  save!
   #send a mail here to the added email ID
   SendMail.password_reset(self).deliver
   logger.info 'sending message to mail'
   #SendMail.delay.password_reset(self)
end



def send_password_mobile

  self.passcode = rand(1000...9999).to_s
logger.info "I am going to Send Message ZZZZZZZZZZZZ" + self.passcode + 'to' + self.mobile_no
full_message = 'Hi '+ self.name + 'Your Passcode  is ' + self.passcode
agent = Mechanize.new
page = agent.get("http://fullonsms.com/login.php")
page.forms.any? { |form| form.name == "LoginForm" }
login_form = page.form("LoginForm")
login_form.MobileNoLogin = "8984433353"
login_form.LoginPassword = "67766"
page = agent.submit(login_form)
page = agent.get "http://fullonsms.com/home.php?show=contacts"
page.forms.any? { |form| form.name == "ComposeForm" }
compose_form = page.form("ComposeForm")
compose_form.MobileNos = self.mobile_no
compose_form.Message =  full_message
page = agent.submit(compose_form)
agent.get("http://fullonsms.com/logout.php?LogOut=1")

 end


def remove_old_password_reset_token
  self.password_reset_token = nil
  save!
end

# def return_current_user
#   current_user.id
#  end

  def to_param
   #'foo'
  #{id}-#{permalink}"
     permalink
  end

def create_paramlink
  self.permalink = self.name.delete(' ')
end

    def encrypt(string)
        secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end


    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

  def validate_password?(submitted_password)
      encrypted_password == encrypt(submitted_password)
  end


   def self.authenticate(email, submitted_password)
    user = User.find_by_email(email)
     #return nil if user.nil?
     #return user if user.validate_password?(submitted_password)
     user && user.validate_password?(submitted_password) ? user : nil
   end


  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password =  encrypt(password)
    end

   def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
   end




end