class ApplicationController < ActionController::Base
	protect_from_forgery
	include SessionsHelper
	def set_mailer_host
	    ActionMailer::Base.default_url_options[:host] = request.host_with_port
	end

	def filter_login
	  	if current_user
	  		redirect_to(current_user)
	  	end
	end

	  def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
     def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
