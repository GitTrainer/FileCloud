class PasswordResetsController < ApplicationController
  def new
  end

	def create
		@user = User.find_by_email(params[:email])
		if @user
		  @user.send_password_reset
		  flash[:notice] = "Instructions to reset your password have been emailed to you. " +
		  "Please check your email."
		  render 'sessions/new'
		else
		  flash[:notice] = "No account was found with that email address"
		  redirect_to root_url
		end
	end

  def edit
  	@user=User.find_by_password_reset_token(params[:id])
  end

  def update
  	@user=User.find_by_password_reset_token(params[:id])
  	if @user.password_reset_sent_at<2.hours.ago
  		redirect_to new_password_reset_path, :alert=>"password reset has expired"
  	elsif @user.update_attributes(params[:user])
  		redirect_to signin_path, :notice =>"password reset has been success"
  	else
 			render 'edit'
  	end
  end
end
