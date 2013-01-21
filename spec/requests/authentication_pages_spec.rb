require 'spec_helper'
require 'factory_girl'
require 'factory_girl_rails'
describe "Authentication " do 

  	subject { page }

	describe "non-admin" do
		let(:user) { FactoryGirl.create(:user_activated) }
		let(:non_admin){FactoryGirl.create(:user_activated,:email=>"Myemail@yahoo.com")}
		describe "Delete user with non-admin" do
			before do
				sign_in non_admin
				visit users_path
				delete user_path(user)
			end
			specify { response.should redirect_to(root_path) } 
		end
	end

	describe "with admin" do
		# binding.pry
		let(:user1){FactoryGirl.create(:user) }
		let(:admin){FactoryGirl.create(:user_admin)}
		FactoryGirl.create(:user3)
		
		describe "delete" do
			before do
				# binding.pry
				sign_in admin
				visit users_path
			end
			it "delete user" do
				expect { click_link('delete') }.to change(User, :count).by(-1)
			end
		end
	end	
end