require 'spec_helper'
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rails'
require 'factory_girl'
require 'factory_girl_rails'

describe "Folders page" do

  describe "when not signed in" do
  	let(:user){FactoryGirl.create(:user)}
		before { visit ("/folders/?user_id=" + user.id.to_s) }
		it "should be go to signin path" do
		   page.should have_content("Please sign in.")
		end
  end

	describe "when signed in" do
		before { visit signin_path }
			let(:user){FactoryGirl.create(:user)}
				before do
					fill_in "Email", :with => user.email
					fill_in "Password", :with => user.password
					click_button "Sign in"
				end
				describe "Create a new folder" do
			    let(:folder){FactoryGirl.create(:folder)}
  				let(:user){FactoryGirl.create(:user)}
					before { visit ("/folders/?user_id="+user.id.to_s) }
			    let(:submit) { "Create Folder" }
					describe "with invalid information" do
		    	  it "should not create a folder" do
		          expect {click_button submit}.not_to change(Folder,:count)
		        end
					end
					describe "with valid information" do
						let(:category){FactoryGirl.create(:category)}
							before do
								fill_in 'Name', with:  "New Example Folder"
								fill_in 'Description', with:  "This is Example Folder"
								select "Laptop", from:  "Category"
							end
							it "Should create a folder" do
								expect{click_button submit}.to change(Folder,:count).by(1)
							end
				  end
			  end

			  describe "show page" do
			    let(:folder){FactoryGirl.create(:folder)}
			    let(:user){FactoryGirl.create(:user)}
			    let(:filestream){FactoryGirl.create(:filestream)}
		      before { visit ("/folders/" + folder.id.to_s + "&?user_id=" + folder.user_id.to_s) }
					it "Should has a name" do
						page.should have_content(folder.name)
					end
					it "Should has a description" do
						page.should have_content(folder.description)
					end
					it "Should has a category" do
						page.should have_content(Category.find(folder.category_id).name)
					end
					it "Should has a upload link" do
						page.should have_selector('a', value:"Upload file")
					end
					it "should have share file button" do
						page.should have_selector('a', value:"Share...")
					end
					it "should delete a File" do
						expect { click_link('Delete') }.to change(Filestream, :count).by(-1)
					end
				end

				describe "Share file" do
				  let(:folder){FactoryGirl.create(:folder)}
			    let(:user){FactoryGirl.create(:user)}
			    let(:filestream){FactoryGirl.create(:filestream)}
		      before do
		       visit  ("/folders/" + folder.id.to_s + "&?user_id=" + folder.user_id.to_s)
		       check('activated[]')
		      end
		      it "should share to selected member " do
						expect { click_button('Save changes') }.to change(Filesharing, :count).by(1)
					end
				end



			describe "Edit page" do
				let(:folder){FactoryGirl.create(:folder)}
				let(:user){FactoryGirl.create(:user)}
				 before do
				 	visit ("/folders/" + folder.id.to_s + "/edit/?user_id=" + folder.user_id.to_s)
				 end
				 it "Should has a name" do
				    page.should have_content(folder.name)
				 end
			     it "Should has a description" do
				    page.should have_content(folder.description)
				 end
			     it "Should has a category" do
				    page.should have_content(Category.find(folder.category).name)
				 end
				 describe "with invalid information" do
				    before do
				 	    fill_in "Name", :with => ""
				 			fill_in "Description", :with => ""
				 	 		click_button "Update Folder"
				 		end
		        it "Should has a name" do
				    	page.should have_content(folder.name)
				 		end
			    	it "Should has a description" do
					    page.should have_content(folder.description)
					 	end
					 	it "Should have notice" do
					 		page.should have_content("Please fill all fields correctly")
					 	end
		     end

		       	 describe "with valid information" do
		       	 	 let(:new_name)  { "New Name" }
		      		 let(:new_description) { "New Description" }
		       	 	 before do
					 	     fill_in "Name", :with => 'new_name'
						 		 fill_in "Description", :with => 'new_description'
						 	 	 click_button "Update Folder"
					 		 end
							 it "Should has a new name" do
							   page.should have_content('new_name')
						   end
						   it "Should has a new name" do
							   page.should have_content('new_description')
						   end
						   it "Should has a blank name field" do
							   page.should have_selector('input', value:"")
						   end
						   it "Should has a blank description field" do
							   page.should have_selector('input', value:"")
						   end
						   it "Should has a please select dropdown list" do
							   page.should have_selector('select', value: "Please select")
						    end
							  it "Should has a create new button" do
							    page.should have_selector('input', value: "Create Folder")
						    end
		         end
			end

			describe "Delete a folder" do
				let(:folder){FactoryGirl.create(:folder)}
				let(:user){FactoryGirl.create(:user)}
				before {
					visit ("/folders/?user_id=" + folder.user_id.to_s)
				}
	 	    it "should delete a folder" do
	 	       expect { click_link('Delete') }.to change(Folder, :count).by(-1)
	      end
	 	    it { should_not have_content(folder.name) }
	 	    it { should_not have_content(folder.description) }
			end
	end
end
