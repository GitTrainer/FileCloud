require 'spec_helper'

describe "SigninPages" do

  # @user.save
  # user.build
  subject{page}
  describe "Signin Pages" do
  	before {visit signin_path}
  	describe "with invalid information" do 
  		before {click_button "Sign in"}
  		it {should have_selector('h1', text: 'Sign in')}
  		it { should have_selector('div.alert.alert-error', text: 'Invalid') }
  	end
  	describe "with valid information" do
  		  let(:user) {FactoryGirl.create(:user)}
  		before do
  			fill_in "Email", with: user.email
  			fill_in "Password", with: user.password
  			click_button "Sign in"
      end
  		it {should_not have_link('Sign in',href: signin_path)}
      it {should have_link('a', :href =>@current_user.user_id.name)}
       it {save_and_open_page}
      # it "should have link edit and create folder in current user log in" do
      #   current_user.should have_link("Edit")
      # end
      # it {should have_link("Edit", :href => ("/users/" + user.id.to_s + "/edit"))}
      # binding.pry
      it "show link back" do
        page.should have_link("Back")
      end
      it "show link edit" do
        page.should have_link("Edit")
      end
      it "show link create folder" do
        page.should have_link("Create folder")
      end
      it "show text lists folder" do
        page.should have_content("List folders:")
      end
      it "show folder share" do
        page.should have_content("List folders are shared by other members :")
      end

      # response.should redirect_to(:action => 'create')

        # it {}
  	end
  	describe "with invalid information" do 
  		before {click_button "Sign in"}
  		#it {should have_selector('title' , text: 'Sign in')}
  		it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      it { should_not have_link("Edit")}
      it { should_not have_link("Create folder")}
  	end
  	

  end
end
