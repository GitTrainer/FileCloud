module SessionsHelper

  	def sign_in(user)
	    cookies.permanent[:remember_token] = user.remember_token
	    self.current_user = user #tao ra mot bien truy cap dc ca controller va view
	    # neu khong co self current_user chi la bien local
 	end

 	def current_user=(user)# same self.current_user=user
  		@current_user = user
  	end

	def current_user
	    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
	    # a||=b  a=a if a#nill a=b if a nill
	    # left to right , stop when a,b true
	    # gan @current_user ve phai @current_user la nill
	end

	def current_user?(user)
    	user == current_user
  	end
  	
	def signed_in?
    	!current_user.nil?
	end

	def sign_out
	    self.current_user = nil
	    cookies.delete(:remember_token)
  	end
  	
end
