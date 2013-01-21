require 'spec_helper'
# require 'Capybara'
require 'factory_girl'
require 'factory_girl_rails'
describe "EdituserPages" do
  subject{page}
  describe "edit user" do
	  	let(:user) { FactoryGirl.create(:user) }
	    before do
	      sign_in user
	      visit edit_user_path(user)
	    end
	  	describe "page edit" do 
	  		it {should have_selector('h1', text: "Editing user")}
	  	end
	  	describe "with invalid information" do 
	  		before {click_button "Create my account"}
	  		# it {should have_selector ('div.alert alert-error'),text: 'The form contains 2 errors.'}
	  		it { should have_content('error') }
	  	end
    end
    describe "with valid information" do 
    	let(:user) { FactoryGirl.create(:user) }
	    before do
	      sign_in user
	      visit edit_user_path(user)
	    end
    	let (:new_name) {"new name"}
    	let (:new_email) {"new@example.com"}
    	before do 
    		fill_in "Name",	with: new_name
    		fill_in "Email",	with: new_email
    		fill_in "Password",	with: user.password
    		fill_in "Confirmation", with: user.password
    		click_button "Create my account"
    	end
    	# it { should have_selector('title', text: new_name) }
        it { should have_selector('div.alert alert-success',text:'Profile updated') }
      	it { should_not have_link('Sign in', href: signin_path) }
     	specify { user.reload.name.should  == new_name }
     	specify { user.reload.email.should == new_email }
     	describe "submitting to the update action" do
  			before { put user_path(user) }
  			specify { response.should redirect_to(signin_path) }
		end
  end
    
end
