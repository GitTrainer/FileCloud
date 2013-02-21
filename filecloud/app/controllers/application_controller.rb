class ApplicationController < ActionController::Base
  protect_from_forgery
 include SessionsHelper


# def current_user
#   @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
# end


  #  def set_mailer_host
  #   ActionMailer::Base.default_url_options[:host] = request.host_with_port
  #   # ActionMailer::Base.default_url_options[:host] = with_subdomain(request.subdomain)
  # end

  #  def set_host_port
  #  	 @host_port = request.host_with_port
  #  end
end
