require 'spec_helper'
require 'factory_girl'
require 'factory_girl_rails'
describe "User pages" do

  subject { page }
		describe "signup" do 
			before { visit '/signup' }
			let (:submit) {"Create my account"}
			describe "with invalid information" do
				 it "should not create a user" do
					expect {click_button submit}.not_to change(User, :count)
				end
			end
			describe "with valid information" do 
				before do
					fill_in "Name",	with: "van dung"
					fill_in "Email", with: "ngvandung2010@gmail.com" 
					fill_in "Password", with: "123456"
					fill_in "Confirmation", with: "123456"
				end
				it "should create a user" do
					expect {click_button submit}.to change(User,:count).by(1)
				end
			describe " send key email active account" do
				let(:user) {FactoryGirl.create(:user)}
				before do
					fill_in "Email",	with:user.email
					fill_in "Password",	with:user.password
					click_button "Sign in"
				end
				# it { should have_link('Sign out', href: signout_path) }
				it { should_not have_link('Sign in', href: signin_path) }
				it { should have_link('Users', href: users_path) }
			end


			end
		end


	
		
end
		




