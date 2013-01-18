require 'spec_helper'
require 'factory_girl'
require 'factory_girl_rails'


describe "PasswordResets" do
  it "emails user when requesting password reset" do
    user = Factory(:user)
    visit '/signin'
    click_link "forgotten password?"
    fill_in "Email", :with => user.email
    click_button "Reset Password"
    current_path.should eq(root_path)
    page.should have_content("Email sent")
  end

  it "does not email invalid user when request password reset" do
    visit '/signin'
    click_link "forgotten password?"
    fill_in "Email", :with => "ngvandung20102gmail.com"
    click_button "Reset Password"
    current_path.should eq(root_path)
    page.should have_content("Email sent")
    last_email.should be_nil
  end
  it "updates the user password when confirmation matches" do
    user = Factory(:user, :password_reset_token => "something", :password_reset_sent_at => 2.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "Password", :with => "123456"
    click_button "Update Password"
    page.should have_content("Password doesn't match confirmation")
    fill_in "Password", :with => "123456"
    fill_in "Password confirmation", :with => "123456"
    click_button "Update Password"
    page.should have_content("Password has been reset")
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
    user = Factory(:user, :password_reset_token => "something", :password_reset_sent_at => 4.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "Password", :with => "123456"
    fill_in "Password confirmation", :with => "123456"
    click_button "Update Password"
    page.should have_content("Password reset has expired")
  end

  # it "raises record not found when password token is invalid" do
  #   lambda {
  #     visit edit_password_reset_path("invalid")
  #   }.should raise_exception(ActiveRecord::RecordNotFound)
  # end
end



