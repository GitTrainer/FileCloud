module SessionsHelper

def current_user

    @current_user ||= User.find_by_remember_token(session[:remember_token])
end
end