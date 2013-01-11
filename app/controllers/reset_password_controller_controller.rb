class ResetPasswordControllerController < ApplicationController

	def create
		@user=User.find_by_email(:email)
		UserMailer.send_reset_password(@user).deliver
	end


	def resetpassword
		
	end
end
