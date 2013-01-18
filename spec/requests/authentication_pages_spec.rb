require 'spec_helper'

describe "Authentication " do 

  	subject { page }

	describe "non-admin" do
		let(:user) { FactoryGirl.create(:user_activated) }
		let(:non_admin){FactoryGirl.create(:user_activated,:email=>"Myemail@yahoo.com")}
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
	# 	let(:user) { FactoryGirl(:user,:email =>"abcddkf@yahoo.com",:status=>true) }
	# 	let(:user_admin){FactoryGirl.create(:user_activated,:admin=>true)}
	# 	# let(:user_admin){FactoryGirl.create(:user_activated,:email=>"cdkdslfa@gmail.com")}
		
	# 	before do
	# 		sign_in user_admin
	# 		visit users_path
	# 	end
	# 	it {should have_selector('div.container h1',text: 'Listing users')}
	# 	it { should have_content('delete') }
	# end	
end