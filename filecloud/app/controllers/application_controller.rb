class ApplicationController < ActionController::Base
  protect_from_forgery
 include SessionsHelper

   def set_mailer_host
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
