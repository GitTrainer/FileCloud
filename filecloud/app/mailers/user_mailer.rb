class UserMailer < ActionMailer::Base
  default :from => "notifications@filecloud.com"
  
  def welcome_email(user)
    mail(:to => user.email, :subject => "Register new account received")
  end
end