class SendMail < ActionMailer::Base
  default :from => "sampleid18@gmail.com"

   def send_patient(user)
      @patient = user 
      mail(:to => @patient.email, :subject => 'Your Feedback Submitted!')
   end
#SendMail.send_patient(@feedback)
  # def send_mail(user)
  # 	@users =  User.all
  #   @recipients = User.all
  #   @recipients.each do |recipient|
  #   		request_to_mail(recipient).deliver
  #   	end
  #   end

    def request_to_mail(recipient, subject)

    	mail :to => recipient.email, :subject => subject
    end


    def user_login_mail(user)
        @doctor = user 
        @subject = 'Logged in User'
        request_to_mail(@doctor, @subject).deliver
        #mail(:to => @doctor.email, :subject => 'Logged in Successfully')
    end

    def user_profile_updated(user)
         @user = user
         @subject = 'Profile Updated'
         request_to_mail(@user, @subject).deliver
    end

    def password_reset(user) 
        @user = user
        mail :to => user.email, :subject => 'password reset' #actually sending the Mail
        logger.info 'in password_reset'
   end 

    def doctor_activated(user)
         @user = user 
         mail :to => user.email, :subject => "Account Activated"
    end

    def comment_mail_to_patient(user,doctor)
         @user = user
         @doctor = doctor
         mail :to => user.email, :subject => 'Doctor added Comment to your Feedback'
    end

    def feedback_submitted(feedback)
        @user = feedback
        mail :to => feedback.email, :subject => 'Feedback form submitted'
    end

    
end