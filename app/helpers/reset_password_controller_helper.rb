module ResetPasswordControllerHelper

	def create()
		user=User_find_by_email(:email)
		UserMailer.send_reset_password(user).diliver
	end
end
