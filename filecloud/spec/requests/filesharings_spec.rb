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
			before do
				@category = Category.new(:name => "Category", :description => "Description")
  			@category.save!
  			@filestream = Filestream.new(:filename => "N/A", :folder_id => 1, :attach_file_name => "abc.jpg", :attach_content_type => "image/*", :attach_file_size => 5000, :download_count => 0 )
  			@filestream.save!
				visit  ("/folders/" + folder.id.to_s + "&?user_id=" + folder.user_id.to_s)
			end
			it "should have Save changes button" do
				page.should have_selector('a', :value => "Save changes")
			end
			it "should have Close button" do
				page.should have_button('Close')
			end
			it "When just has 1 user" do
				expect { click_button('Save changes') }.to change(Filesharing, :count).by(0)
			end
			it "1 user in DB" do
				User.all.length.should equal(1)
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
			let(:newuser){FactoryGirl.create(:newuser)}
			let(:folder){FactoryGirl.create(:folder)}
			let(:filestream){FactoryGirl.create(:filestream)}
			before do
				@category = Category.new(:name => "Category", :description => "Description")
				@category.save!
				@filesharing = Filesharing.new(:file_id => filestream.id, :shared_user_id => newuser.id)
				@filesharing.save!
				visit ("/folders/" + folder.id.to_s + "&?user_id=" + folder.user_id.to_s)
				uncheck('activated[]')
			end
			it "Uncheck checked member" do
				expect { click_button('Save changes') }.to change(Filesharing, :count).by(-1)
			end
		end

		describe "When DB has more than 2 users with selection" do
			let(:folder){FactoryGirl.create(:folder)}
			let(:fakeuser){FactoryGirl.create(:fakeuser)}
			before do
			  @test_user = User.create(name:"Test member",email:"test@gmail.com",password:"123456",password_confirmation:"123456",status:'t')
			  @test_user.save!
				@category = Category.new(:name => "Category", :description => "Description")
  			@category.save!
  			@filestream = Filestream.new(:filename => "N/A", :folder_id => 1, :attach_file_name => "abc.jpg", :attach_content_type => "image/*", :attach_file_size => 5000, :download_count => 0 )
  			@filestream.save!
				visit  ("/folders/" + folder.id.to_s + "&?user_id=" + folder.user_id.to_s)
				check('activated[]')
			end
				it "should share to selected member " do
					expect { click_button('Save changes') }.to change(Filesharing, :count).by(1)
				end
			end
		describe "When DB has more than 2 users and no selection" do
			let(:folder){FactoryGirl.create(:folder)}
			before do
				@test_user = User.create(name:"Test member",email:"test@gmail.com",password:"123456",password_confirmation:"123456",status:'t')
				@test_user.save!
				@category = Category.new(:name => "Category", :description => "Description")
				@category.save!
				@filestream = Filestream.new(:filename => "N/A", :folder_id => 1, :attach_file_name => "abc.jpg", :attach_content_type => "image/*", :attach_file_size => 5000, :download_count => 0 )
				@filestream.save!
				visit  ("/folders/" + folder.id.to_s + "&?user_id=" + folder.user_id.to_s)
			end
				it "should don't share to any member when uncheck all or no selection" do
					expect { click_button('Save changes') }.to change(Filesharing, :count).by(0)
				end
		end
	end
end
