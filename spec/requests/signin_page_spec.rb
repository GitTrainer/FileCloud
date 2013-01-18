require 'spec_helper'
require 'factory_girl'
require 'factory_girl_rails'
# require 'integration_test_helper'
describe "sign -in page " do
	subject { page }
	describe "sign in" do
		before {visit signin_path}
		
		describe "with invalid infor" do
			before {click_button "Sign in"}
			 	it {should have_selector('div.alert.alert-error',text: 'Invalid')}
				it { should have_selector('title', text: 'a') }
			 end

		describe "with valid information" do
			let(:user) {FactoryGirl.create(:user)}
			before do
				fill_in 'Email',    with: user.email
       			fill_in 'Password', with: user.password
				click_button "Sign in"
			end
	     	it { should_not have_link('Sign out', href: signout_path) }#not activated account
	     	it { should have_link('Sign in', href: signin_path) }

		end

		describe "activate account and sign out" do
			
			let(:user_activated) {FactoryGirl.create(:user_activated)}
			
			describe "sign in-out with user activated" do
				before do
					fill_in 'Email',    with: user_activated.email
	       			fill_in 'Password', with: user_activated.password
					click_button "Sign in"
				end

				it { should have_link('Sign out', href: signout_path) }
		     	it { should_not have_link('Sign in', href: signin_path) }
		     	it { should have_link('Users', href: users_path) }

		     	describe "update user" do
		     		before do
		     			visit edit_user_path(user_activated)
		     			fill_in "Name" ,with: user_activated.name
		     			fill_in "Email",with: user_activated.email
		     			fill_in "Password",with: user_activated.password
		     			fill_in "Confirmation",with: user_activated.password_confirmation
		     			click_button 'Update User'
		     		end
	     			it {should have_selector('div.alert.alert-notice',text: 'successfully updated')}
	     			it { should have_link('Edit', href: edit_user_path(user_activated) )}
	     		end

	     		describe "test list user" do
	     			before do
	     				click_link 'Users'
	     			end
	     			it {should have_selector('div.container h1',text: 'Listing users')}
	     		end

		     	describe "sign out " do

			     	before do 
						click_link 'Sign out'
			     	end

			     	it { should have_link('Sign in', href: signin_path) }
			     	it { should_not have_link('Sign out', href: signout_path) }
		   		 end

		   		 describe "Send Password reset with email valid" do
	     			before do
	     				visit signin_path
	     				click_link 'forgot passowrd'
	     				fill_in "email",with: "dangkhanhjava@gmail.com"
	     				click_button 'Reset Password'
	     			end
	     			it{should_not have_content("Please enter your email")}
	     			it{should have_content("Please check your email to reset password")}
	     			# page.should have_content("")
			    end

			    describe "Send Password reset with email invalid" do
	     			before do
	     				visit signin_path
	     				click_link 'forgot passowrd'
	     				fill_in "email",with: "dadasdaadfas@gmail.com"
	     				click_button 'Reset Password'
	     			end
	     			it{should have_content("Could not found email")}
	     			it{should_not have_content("Please check your email to reset password")}
			    end

			    describe "Update password reset" do
			    	let(:admin){FactoryGirl.create(:user_admin,:password_reset=>"abc",:password_reset_sent_at=>1.hour.ago)}
	     			before do
	     				visit edit_reset_password_path(admin.password_reset)
	     				fill_in "Password", :with => "1234567"
    					fill_in "Confirmation", :with => "1234567"
    					click_button "Update User"
	     			end
	     			it{should have_content("You have just changed your passowrd")}
			    end

		    end 	
		end
	end
end