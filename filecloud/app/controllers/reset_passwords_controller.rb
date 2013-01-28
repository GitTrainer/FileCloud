class ResetPasswordsController < ApplicationController

	def create
		@user=User.find_by_email(params[:email])
		if @user
			@user.send_resset_password
			flash.now[:notice]='Please check your email to reset password'
			render 'sessions/new'
		else
			redirect_to new_reset_password_path, :notice => "Could not found email! '#{params[:email]}'"
		end	
	end

	def update 
		@user=User.find_by_password_reset(params[:id])
		@user.password_reset=nil
		if @user.password_reset_sent_at < 24.hours.ago
			redirect_to new_reset_passwords
		elsif @user.update_attributes(params[:user])
			sign_in @user
			redirect_to @user,:notice=>"You have just changed your passowrd"
		else
			render 'edit'
		end
	end

	def new
	end

	def edit
		@user=User.find_by_password_reset(params[:id])
	end
	
end
