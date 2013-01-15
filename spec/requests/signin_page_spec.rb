require 'spec_helper'

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

		# describe "activate account" do
		# 	let(:user) {FactoryGirl.create(:user)}
			
		# 	before do
		# 		fill_in 'Email',    with: user.email
  #      			fill_in 'Password', with: user.password
		# 		click_button "Sign in"
		# 	end
	 #     	it { should have_link('Sign out', href: signout_path) }#not activated account
	 #     	it { should_not have_link('Sign in', href: signin_path) }
		# end
		
	end

end