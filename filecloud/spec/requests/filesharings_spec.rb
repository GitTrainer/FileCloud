require 'spec_helper'

describe "Filesharings" do
	describe "Share file" do
		before { visit signin_path }
		let(:user){FactoryGirl.create(:user)}
			before do
				fill_in "Email", :with => user.email
				fill_in "Password", :with => user.password
				click_button "Sign in"
			end
		describe "Share file" do
			let(:folder){FactoryGirl.create(:folder)}
			let(:filestream){FactoryGirl.create(:filestream)}
			before do
				visit  ("/folders/" + folder.id.to_s + "&?user_id=" + folder.user_id.to_s)
				check('activated[]')
			end
			it "should have Save changes button" do
				page.should have_selector('a', :value => "Save changes")
			end
			it "should have Close button" do
				page.should have_button('Close')
			end
			it "should share to selected member " do
				expect { click_button('Save changes') }.to change(Filesharing, :count).by(1)
			end
			it "should have folder details" do
				page.should have_selector('h1', :value => "Folder details")
			end
			it "should have go back to folders link" do
				page.should have_selector('a', :value => "Go to Folders")
			end
			it "should have share folder link " do
				page.should have_selector('a', :value => "Share folder to members")
			end
		end
		describe "should disable to share member when click that member" do
			let(:folder){FactoryGirl.create(:folder)}
			before do
				@filesharing = Filesharing.new(:file_id => 1, :shared_user_id => 1)
				@filesharing.save!
				visit ("/folders/" + folder.id.to_s + "&?user_id=" + folder.user_id.to_s)
				uncheck('activated[]')
			end
			it "Uncheck checked member" do
				expect { click_button('Save changes') }.to change(Filesharing, :count).by(-1)
			end
		end
	end
end
