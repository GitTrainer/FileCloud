class UserMailer < ActionMailer::Base
  default :from => "framgiatest@gmail.com"

  def welcome_email(user)
    @user = user
    mail(:to => @user.email, :subject => "Register new account received")
    headers['X-MC-GoogleAnalytics'] = "localhost:3000"
    headers['X-MC-Tags'] = "welcome"
  end

  def share_link_email(user,share_link)
  	# binding.pry
  	@user,@share_link = user,share_link
    # @user = user
  	mail(:to => @user.email, :bcc => @share_link.email, :subject => "welcome")
  end
end