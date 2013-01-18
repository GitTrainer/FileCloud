require 'spec_helper'
require 'factory_girl'
require 'factory_girl_rails'

describe "DeletePages" do
	it{should_not have_link ('Destroy')}
	
  describe "as admin user" do
  	binding.pry
    let(:admin) { FactoryGirl.create(:user) }
    before do
      sign_in admin
      visit users_path
        
    end
	  it { should have_link('Destroy', href: user_path(User.first)) }
	  it {should have_content("Listing users")} 
	  it "should be able to delete another user" do
	    expect { click_link('Destroy') }.to change(User, :count).by(-1)
	  # end   binding.pry
	  
  end
	describe "as no admin user" do 
		let(:user){FactoryGirl.create(:user)}
		let(:no_admin){FactoryGirl.create(:user)}
		before {sign_in no_admin}
		describe "submit a destroy to the users#destroy action" do 
			before {destroy user_path(user)}
			specify {response.should redirect_to(root_path)}
		end
	end
end
