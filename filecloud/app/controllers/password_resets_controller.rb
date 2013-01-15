class PasswordResetsController < ApplicationController
  def new
  end
  def create
  	user=User.find_by_email(parems[:email])
  	user.send_password_reset if user
  	redirect_to root_url, :notice =>"Email send with PasswordReset"

  end

  def edit
  	@user=User.find_by_password_reset_token!(params[:id])
  end

  def update
  	@user=User.find_by_password_reset_token!(params[:id])
  	if @user.password_reset_send_at< 3.hours.ago
  		redirect_to new_password_reset_path, :alert=>"password reset has expired"
  	elsif @user.update_attributes(params[:user])
  		redirect_to root_url, :notice =>"password reset has been valid"
  	else
  			render 'edit'
  	end
  end	
end
