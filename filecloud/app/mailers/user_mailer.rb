class UserMailer < ActionMailer::Base
  default from: "ngvandung2010@gmail.com"
  def welcome_email(user)
    @user = user
    #@url  = "http://localhost:3000/users/#{user.login}/activate"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end


  def password_reset(user)
   @user = user
  mail(:to => user.email, :subject => "password reset")
  end
  def share_folder(activated_id)
    @user_email = User.where(:id => activated_id).first.email  
    mail(:to => @user_email, :subject => "You was shared folder.")
  end





end


#@url = "http://0.0.0.0:3000/users/#{user.activation_token}/activate"

#<%= url_for(:action => 'activate', :controller => 'users',
#	:host =>'localhost:3000',:id=>@user.id,:active_code =>@activated) %>