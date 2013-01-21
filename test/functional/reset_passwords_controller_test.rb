# require 'test_helper'

# class ResetPasswordsControllerTest < ActionController::TestCase
# 	setup do
# 	    @user = users(:two)
# 	end
# 	test "test_for_got_password" do
# 		# post :create, u: { email: @user.email, login: @user.login, name: @user.name,password: "123456",password_confirmation: "123456" }
# 		user=@user
# 		email = UserMailer.send_password(user).deliver
# 	    assert !ActionMailer::Base.deliveries.empty?
# 	    assert_equal [user.email], email.to
# 	end
# end