require 'spec_helper'

describe "SigninPages" do
  subject{page}
  describe "Signin Pages" do
  	before {visit '/signin'}
  	describe "with invalid information" do 
  		before {click_button "Sign in"}
  		it {should have_selector('h1', text: 'Sign in')}
  		it { should have_selector('div.alert.alert-error', text: 'Invalid') }
  	end
  	describe "with valid information" do
  		let(:submit) {FactoryGirl.create(:user)}
  		before do
  			fill_in "Email", with: "ngvandung2010@gmail.com"
  			fill_in "Password", with: "123456"
  			click_button "Sign in"
  		end
  		it {should_not have_link('Sign in',href:'signin_path')}
  		#it {response.should have_selector('a',:href=>@current_user.name)}


  	end
  	describe "with invalid information" do 
  		before {click_button "Sign in"}
  		#it {should have_selector('title' , text: 'Sign in')}
  		it { should have_selector('div.alert.alert-error', text: 'Invalid') }
  	end
  	

  end
end
