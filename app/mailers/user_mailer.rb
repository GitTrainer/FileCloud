class UserMailer < ActionMailer::Base
  default from: "dangkhanhit@gmail.com"

  def welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to My  Site")
  end

  def send_reset_password(user)
  	@user = user
    mail(:to => "dangkhanhjava@gmail.com", :subject => "You have Forgot password")#replaced user.mail to dangkhanhjava
  end
end
