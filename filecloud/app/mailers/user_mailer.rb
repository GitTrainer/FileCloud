class UserMailer < ActionMailer::Base
  default from: "ngvandung2010@gmail.com"
  def welcome_email(user)
    @user = user
    #@url  = "http://localhost:3000/users/#{user.login}/activate"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end

  def password_reset(user)
      # binding.pry
    @user = user
    # @url  = "http://localhost:3000/users/#{user.password_reset_token}"
  mail(:to => @user.email, :subject => "password reset")
  end

  def share_folder(activated_id, folder_id)
    @user_email = User.where(:id => activated_id).first.email
    @folder_id = folder_id
    @user_id = activated_id
    mail(:to => @user_email, :subject => "You was shared folder.")
  end
	 def share_file(activated_id,file_id)
    @user_email = User.where(:id => activated_id).first.email
		@file_id = file_id
    mail(:to => @user_email, :subject => "You was shared file.")
  end





end


#@url = "http://0.0.0.0:3000/users/#{user.activation_token}/activate"

#<%= url_for(:action => 'activate', :controller => 'users',
#	:host =>'localhost:3000',:id=>@user.id,:active_code =>@activated) %>
