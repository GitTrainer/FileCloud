class UserMailer < ActionMailer::Base
  default from: "ngvandung2010@gmail.com"
  def welcome_email(user)
    @user = user
    #@url  = "http://localhost:3000/users/#{user.login}/activate"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end



  
end


#@url = "http://0.0.0.0:3000/users/#{user.activation_token}/activate"

#<%= url_for(:action => 'activate', :controller => 'users',
#	:host =>'localhost:3000',:id=>@user.id,:active_code =>@activated) %>