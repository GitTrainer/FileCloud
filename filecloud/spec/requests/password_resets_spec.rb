require 'spec_helper'
require 'factory_girl'
require 'factory_girl_rails'
require 'capybara/rails'

describe "PasswordResets" do
  subject{page}
  # it "emails user when requesting password reset" do
  #   user = FactoryGirl.create(:user)
  #   visit '/signin'
  #   click_link "forgotten password?"
  #   fill_in "Email", :with => user.email
  #   click_button "Reset Password"
  #   current_path.should eq(signin_path)
  #   page.should have_content("Instructions to reset your password have been emailed to you. " +
  #   "Please check your email.")
  # end



# it "emails user when requesting password reset" do
#         user = FactoryGirl.create(:user)
#         visit signin_path
#         click_link "password"
#         fill_in "Email", :with => user.email
#         click_button "Reset Password"
#         current_path.should eq(signin_path)
#         page.should have_content("Please check your endmail")
#         last_email.to.should include(user.email)
#       end

  describe "reset password" do
       user = FactoryGirl.create(:user,:email=>"kahddndda@yahoo.com")
       before do
          visit signin_path
          click_link 'forgotten password?'
          fill_in "Email", :with => user.email
          click_button "Reset Password"
       end
       # current_path.should eq(signin_path)
        it{should have_content("Please check your email")}
        # last_email.to.should include(user.email)
  end

  it "does not email invalid user when request password reset" do
    visit '/signin'
    click_link 'forgotten password?'
    fill_in "Email", :with => "ngvandddung2010@gmail.com"
    click_button 'Reset Password'
    # current_path.should eq(root_path)
    # page.should have_content("Email")
    # last_email.should be_nil
    # click_button "Reset Password"
    page.should have_content("No account was found with that email address")
  end
  it "updates the user password when confirmation matches" do
    user = FactoryGirl.create(:user,:email=>"dlkjfal@yahoo.com", :password_reset_token => "dfgdgdbdbd", :password_reset_sent_at => 1.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "Password", :with => "123456"
    fill_in "Password confirmation",:with =>"dksdjfhkhs"
    click_button "Update Password"
    page.should have_content("Password doesn't match confirmation")
    fill_in "Password", :with => "123456"
    fill_in "Password confirmation", :with => "123456"
    click_button "Update Password"
    page.should have_content("password reset has been success")
  end


# it 'updates the user password and sign them in when confirmation matches' do
# 	user = Factory(:user, :password_reset_token => 'something', :password_reset_sent_at => 1.hour.ago)
# 	visit reset_password_path(user.password_reset_token)
# 	fill_in 'Password', :with => '123456'
# 	click_button 'Update Password'
# 	page.should have_content('Password doesn\'t match confirmation')
# 	fill_in 'Password', :with => '123456'
# 	fill_in 'Password confirmation', :with => '123456'
# 	click_button 'Update Password'
# 	page.should have_content('password was reset')
# end

  it "when password token has expired" do
    user = FactoryGirl.create(:user,:email=>"dlkfjsal@yahoo.com", :password_reset_token => "1209876543", :password_reset_sent_at => 4.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "Password", :with => "123456"
    fill_in "Password confirmation", :with => "123456"
    click_button "Update Password"
    page.should have_content("password reset has expired")
  end

end



