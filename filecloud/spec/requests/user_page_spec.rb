require 'spec_helper'

describe "user page" do
	subject {page}

	describe "sign-up " do 
		before {visit signup_path}
		let(:submit) {"Create User"}
		describe "with invalid infor " do
			it "should not create user" do
				expect {click_button submit}.not_to change(User,:count)
			end
		end

		describe "with valid infor" do
			before do
				fill_in "Name",with: "abc12345"
				fill_in "Email",with: "abc@yahoo.com"
				fill_in "Password",with: "123456"
				fill_in "Confirmation",with: "123456"
			end
			it "should crate user" do
			expect {click_button submit}.to change(User,:count).by(1)
			end
		end
	end
end