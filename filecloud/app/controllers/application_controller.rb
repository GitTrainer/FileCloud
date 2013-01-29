class ApplicationController < ActionController::Base
  #  protect_from_forgery
  #
  #  rescue_from CanCan::AccessDenied do |exception|
  #    redirect_to root_path, :alert => exception.message
  #  end

  def set_mailer_host
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
  protect_from_forgery

  def has_role?(current_user, role)
    return !!current_user.roles.find_by_name(role.to_s.camelize)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

end
