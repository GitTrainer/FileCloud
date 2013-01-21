require 'spec_helper'
require 'factory_girl'
require 'factory_girl_rails'

describe "DeletePages" do

	it{should_not have_link ('Destroy')}
	
  describe "as admin user" do
  	binding.pry
   	let(:admin){FactoryGirl.create(:user, :email=>"ngvan@gmail.com",:admin=>true)}
    before do
      sign_in admin
      visit users_path
        
    end
     binding.pry
	  it { should_not have_link('Destroy', href: user_path(User.first)) }
	  #it {save_and_open_page}
	  it "should have content listing uers" do
	      page.should have_selector('h1', :text => "Listing users") 
	  end
	  
	  it "should be able to delete another user" do
	    expect { click_link('Destroy') }.to change(User, :count).by(-1)
	 
  	  end
  	  
 end
 describe "as a non-signed-in user" do
	 	let(:user){FactoryGirl.create(:user, :email=>"ngvddan@gmail.com",:admin=>false)}
    	before do
	    	sign_in user
	        visit users_path
    	end
    	it {should_not have_link("Destroy")}
 end
end
