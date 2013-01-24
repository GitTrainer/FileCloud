class PasswordResetsController < ApplicationController
  def new
  end
#   def create
#   	user=User.find_by_email(params[:email])
#   	#binding.pry
#     if user
#       user.send_password_reset 
#       binding.pry
#   	  redirect_to 'sessions/new', :notice =>"Email send with PasswordReset"

#   end
# end
def create
  
  @user = User.find_by_email(params[:email])

    
     
     if @user
      @user.send_password_reset
     #binding.pry
      flash[:notice] = "Instructions to reset your password have been emailed to you. " +
    "Please check your email."
      render 'sessions/new'

    #redirect_to root_url, :notice => "Email sent with password reset instructions."
      else
        flash[:notice] = "No account was found with that email address"
        redirect_to root_url
      # else
      #   redirect_to new_password_resets_path, :notice => "Could not found email! '#{params[:email]}'"
      end
end

  def edit
  	@user=User.find_by_password_reset_token(params[:id])
  end

  def update
  	@user=User.find_by_password_reset_token(params[:id])
   
   # @user.password_reset_token=nil
  	if @user.password_reset_sent_at<2.hours.ago
    
  		redirect_to new_password_reset_path, :alert=>"password reset has expired"
      
  	elsif @user.update_attributes(params[:user])
      
  		redirect_to signin_path, :notice =>"password reset has been success"
  	else
  			render 'edit'
  	end
  end

end
