class SessionsController < ApplicationController

	def new
		
	end

	def create
		# binding.pry
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
    	redirect_to root_url
	end
end
