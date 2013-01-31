require 'spec_helper'
require 'factory_girl'
require 'factory_girl_rails'
describe "seperate link and screan file"  do
	
	subject { page }
	
	let(:user) { FactoryGirl.create(:user) }
	let(:folder) { FactoryGirl.create(:folder) }
	let(:file_up_load) { FactoryGirl.create(:file_up_load) }

	let(:user1){FactoryGirl.create(:user,:email=>"Myemail@yahoo.com")}
	let(:folder1) { FactoryGirl.create(:folder,:user =>user1) }
	let(:file1) { FactoryGirl.create(:file_up_load,:folder=>folder1) }

	describe "not signin" do
		
		describe "not login and show folder" do
			before {visit folder_path(folder.id)}
			it { should have_link('Sign in', href: signin_path) }
		end

		describe "not login and edit folder" do
			before {visit edit_folder_path(folder.id)}
			it { should have_link('Sign in', href: signin_path) }

		end

		describe "not login and show file" do
			before {visit file_up_load_path(file_up_load.id)}
			it { should have_link('Sign in', href: signin_path) }
		end
			it{should have_content("Please sign in!")}

		describe "not login and download file" do
			before {visit download_file_up_load_path(file_up_load.id)}
			it { should have_link('Sign in', href: signin_path) }
		end
	end
	
	describe "with signin" do
		
		before{sign_in user}

		describe "login and download file's other user" do
			before do 
				visit users_path
				visit download_file_up_load_path(file1.id)
			end
			it {should have_content("Not correct user!")}
		end

		describe "login  and file's other user" do
			before {visit file_up_load_path(file1.id)}
			it {should have_content("Not correct user!")}
		end
	end
	
end