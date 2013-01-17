require 'spec_helper'
require 'factory_girl_rails'
require 'factory_girl'

describe "Folders" do
     let(:category){FactoryGirl.create(:category)}
     before do
    	 @folder=category.folders.build(name:"Example Folder",category_id:category.id,description:"This is Example Folder")
    	 @folder.save
    	end

	describe "Folders index page" do
		before { visit '/folders'}
		  it { should have_content("Edit") }
		  it { should have_content("Show") }
		  it { should have_content("Delete") }
		it { should have_selector('select', value: "Please select") }
	end

	describe "Create a new folder" do
	    before { visit '/folders'}
	    let(:submit) { "Create Folder" }
		describe "with invalid information" do
    	    it "should not create a category" do
            expect {click_button submit}.not_to change(Folder,:count)
            end
		end
#		describe "with valid information" do
#			before do
#				fill_in 'Name', :with => "England"
#				fill_in 'Description', :with => "England"
#				fill_in "category_id", with:category_id
#			end
#			it "Should create a folder" do
#				 expect{click_button submit}.to change(Folder,:count).by(1)
#			end
#			describe "after saving the folder" do
#        		before { click_button submit }
#        		let(:folder) { Folder.find_by_name('England') }
#        		it { should have_selector('table', value: "England") }
#        		it { should have_selector('table', value: "England") }
#     		    end
	end
end
