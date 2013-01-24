class ApplicationController < ActionController::Base
  protect_from_forgery
 include SessionsHelper
 # def current_user
 # @current_user || User.find_by_remember_token!(cookies[:remember_token]) if cookies[:remember_token]
 # end
   def set_mailer_host
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
