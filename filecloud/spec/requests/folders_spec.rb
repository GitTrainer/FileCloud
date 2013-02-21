require 'spec_helper'

describe "Folders" do
  let(:category){FactoryGirl.create(:category)}
     let(:folder){FactoryGirl.create(:folder)}
     before do
     @folder = category.folders.build(name:"Folder one",category_id:category.id,description:"This is Folder one")
     @folder.save!
     end

	describe "Folder index" do
		before { visit '/folders'}
		it "should has a Edit" do
			page.should have_content 'Edit'
		end
		it "should has a Show" do
			page.should have_content 'Show'
		end
		it "should has a Delete" do
			page.should have_content 'Destroy'
		end
	end

	describe "Create new folders" do
		before { visit new_folder_path }
		let(:submit){"Create Folder"}
	

	describe "with valid information" do
     before do
      fill_in "Name",   with:"folder"
      fill_in "Description", with:"This Folder one"
      select category.name, :from=>'folder_category_id'
      
     end

        it "should create a new folder" do
        expect{click_button submit}.to change(Folder,:count).by(1)
       end
   end
   end

end
