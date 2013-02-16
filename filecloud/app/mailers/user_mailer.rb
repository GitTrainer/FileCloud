class UserMailer < ActionMailer::Base
  default from: "dangkhanhit@gmail.com"

  def welcome_email(user)
    @user = user
    @activation_code=user.login
    mail(:to =>@user.email, :subject => "Welcome to My  Site")
  end

  def send_password(user)
  	@user = user
    mail(:to => @user.email, :subject => "You have Forgot password")#replaced user.mail to dangkhanhjava
  end

  def send_email_notify_sharefile(user,file_up_load,file_share)
   @user=user
   @file_up_load=file_up_load
   @file_share=file_share
   mail(:to=>@user.email,:subject=>"#{@file_up_load.attach_file_name} (#{@user.email})")
  end
end
