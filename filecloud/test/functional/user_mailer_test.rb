require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end
 def test_welcome_email
     # user = User.new(name: "First user",email: "boycodontimgirlcodoc_no1@zing.vn",login: "actived",status: true,password: "123456",password_confirmation: "123456")
    # user=User.new
      # Send the email, then test that it got queued
      user = users(:one)
      email = UserMailer.welcome_email(user).deliver
      assert !ActionMailer::Base.deliveries.empty?
   
      # Test the body of the sent email contains what we expect it to
      assert_equal [user.email], email.to
      assert_equal "Welcome to My Site", email.subject
      assert_match(/<h1>Welcome #{user.name}<\/h1>/, email.encoded)
  end
end
