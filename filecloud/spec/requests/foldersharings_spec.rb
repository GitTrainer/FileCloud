require 'spec_helper'

describe "Foldersharings" do

  describe "when not signed in" do
  	let(:folder){FactoryGirl.create(:folder)}
		before { visit ("/foldersharings/?folder_id="+folder.id.to_s) }
		it "should be go to signin path" do
		   page.should have_content("please sign in")
		end
  end
	describe "When signed in" do
		before { visit signin_path }
		let(:user){FactoryGirl.create(:user)}
			before do
				fill_in "Email", :with => user.email
				fill_in "Password", :with => user.password
				click_button "Sign in"
			end
		describe "Index page of sharing folders to other members" do
			let(:folder){FactoryGirl.create(:folder)}
  		let(:user){FactoryGirl.create(:user)}
			before { visit ("/foldersharings/?folder_id="+folder.id.to_s) }

			it "should have share folders contents" do
				page.should have_selector('h1', :text => "Share folder to members")
			end
			it "should have choose members contents" do
				page.should have_selector('h3', :text => "Choose members to share folder")
			end
			it "should have Select all members link" do
				page.should have_link('Select', :href => "#")
			end
			it "should have Deselect all members link" do
				page.should have_link('Deselect', :href => "#")
			end
			it "should have Back to Folder link" do
				page.should have_link('Back to Folder', :href => ("/folders/"+folder.id.to_s+"&?user_id="+user.id.to_s))
			end
			it "should have share button" do
				page.should have_selector('input', :value => "Share")
			end
			it "Number of users in DB should be equal to number of users in list + 1" do
					User.count - 1 == User.find_by_sql(["select id from users where id != ?",user.id]).length
			end
		end

		describe "should share a selected members" do
			let(:folder){FactoryGirl.create(:folder)}
  		let(:user){FactoryGirl.create(:user)}
			before do
				visit ("/foldersharings/?folder_id="+folder.id.to_s)
					check('activated_')
			end

			it "should not create a category" do
         expect { click_button('Share') }.to change(Foldersharing, :count).by(1)
      end
		end

		describe "should disable to share member when click that member" do
			let(:user){FactoryGirl.create(:user)}
			let(:folder){FactoryGirl.create(:folder)}
			before do
				@foldersharing = Foldersharing.new(folder_id: folder.id,shared_user_id: user.id)
    	  @foldersharing.save!
				visit ("/foldersharings/?folder_id="+folder.id.to_s)
				uncheck('activated[]')
			end
			it "Uncheck checked member" do
				expect { click_button('Share') }.to change(Foldersharing, :count).by(-1)
			end
		end
	end
end
