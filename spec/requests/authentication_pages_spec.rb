require 'spec_helper'

describe "Authentication " do 

  	subject { page }

	describe "non-admin" do
		let(:user) { FactoryGirl.create(:user_activated) }
		let(:non_admin){FactoryGirl.create(:user)}
		before do
			sign_in non_admin
			visit users_path
		end
		describe "Delete user with non-admin" do
			before do
				delete user_path(user)
			end
			specify { response.should redirect_to(root_path) } 
		end
	end

	# describe "with admin" do
	# 	let(:user) { FactoryGirl.create(:user_activated) }
	# 	let(:user_admin){FactoryGirl.create(:user_admin)}
	# 	before do
	# 		sign_in user_admin
	# 		visit users_path
	# 	end
	# 	it {should have_selector('div.container h1',text: 'Listing users')}
	# 	it { should_not have_link('delete', href: user_path(user_admin)) }
	# 	it { should have_link('delete', href: user_path(user)) }
 #        it "should be able to delete another user" do
 #       		expect { click_link('delete') }.to change(User, :count).by(-1)
	# 	end
	# end	
end