class ManualResetsController < ApplicationController

	def new
	end

	def create
		 user = User.find_by_email(params[:email])
		 flash[:success] = 'Old password   '+User.find_by_email('sahu.ajaykumar4@gmail.com').encrypted_password
		 user.manual_reset_password
		redirect_to root_path, 
:notice => "password has been reset successfully                   "+ User.find_by_email('sahu.ajaykumar4@gmail.com').encrypted_password
	end
end
