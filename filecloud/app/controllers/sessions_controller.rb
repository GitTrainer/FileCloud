class SessionsController < ApplicationController
	
	before_filter :filter_login, only: [:new,:create]

	def new
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			if user.status?
				sign_in user
	      		redirect_to user
      		else
      			flash.now[:error] = 'Please check your email to activation' 
      			render 'new'
      		end
		else
	      	flash.now[:error] = 'Invalid email/password combination'
	      	render 'new'
	    end
	end

	def destroy
		sign_out
    	redirect_to home_path
	end
	
end
