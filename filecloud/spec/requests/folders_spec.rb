require 'spec_helper'
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rails'
require 'factory_girl'
require 'factory_girl_rails'

describe "Folders" do
	 let (:user) {FactoryGirl.create(:user)}
     let(:category){FactoryGirl.create(:category)}
     # let(:folder){FactoryGirl.create(:folder)}
     before do
    	 @folder = category.folders.build(name:"Example Folder",category_id:category.id,description:"This is Example Folder")
    	 @folder.save!
    	end

			describe "Category index page" do
				before  do
					sign_in user
					visit '/folders'
				end
			  	it "Should has a Edit" do
				  page.should have_content('Edit')
				end
				it "Should has a Show details" do
				  page.should have_content('Show details')
				end

			end
		
			describe "Create a new folder" do
			    before do
			    	sign_in user
			    	visit '/folders'
			    end
			    let(:submit) { "Create Folder" }
				describe "with invalid information" do
		    	    it "should not create a category" do
		                expect {click_button submit}.not_to change(Folder,:count)
		            end
				end
				describe "with valid information" do
					before do
						fill_in 'Name', with:  "New Example Folder"
						fill_in 'Description', with:  "This is Example Folder"
						select category.name, from:  "Category"
					end
					it "Should create a folder" do
						 expect{click_button submit}.to change(Folder,:count).by(1)
					end
				end
			end

			describe "show page" do
			   let(:folder){FactoryGirl.create(:folder, :name => "bongda", :description =>"dantri")}
		       before { visit folder_path(@folder) }
		     	it "Should has a name" do
				    page.should have_content(text: folder.name)
				end
			    it "Should has a description" do
				    page.should have_content(text: folder.description)
				end
			    it "Should has a category" do
				    page.should have_content(Category.find(text: folder.category).name)
				end
				it "Should has a upload link" do
				    page.should have_selector('a', value:"Upload file")
				end

				 it "should list files in this folder" do
					  @folder.filestreams.each do |f|
				     	  page.should have_selector('td',text:f.attach_file_name)
					      page.should have_selector('td',text:"Download")
					      page.should have_selector('td',text:"Delete")
					      it "should delete a File" do
						     expect { click_link('Delete') }.to change(Filestream, :count).by(-1)
						 end
		              end
		         end
			end

			describe "Edit page" do
				 before do
				 	sign_in user
				 	visit edit_folder_path(@folder) 
				 end
				 it "Should has a name" do
				    page.should have_content(@folder.name)
				 end
			     it "Should has a description" do
				    page.should have_content(@folder.description)
				 end
			     it "Should has a category" do
				    page.should have_content(Category.find(@folder.category).name)
				 end
				 describe "with invalid information" do
				    before do
				 	    fill_in "Name", :with => ""
				 		fill_in "Description", :with => ""
				 	 	click_button "Update Folder"
				 	end
		          	it "Should has a name" do
				    	page.should have_content(@folder.name)
				 	end
			    	 it "Should has a description" do
					    page.should have_content(@folder.description)
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
				before do
					sign_in user
				end
				let(:folder) { FactoryGirl.create(:folder) }
		   	    before { visit '/folders'}
		   	    it "should delete a folder" do
		   	       expect { click_link('Delete') }.to change(Folder, :count).by(-1)
		        end
		   	    it { should_not have_content(folder.name) }
		   	    it { should_not have_content(folder.description) }
			end

end
