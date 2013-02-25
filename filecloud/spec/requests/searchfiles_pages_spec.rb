require 'spec_helper'
require 'factory_girl'
require 'factory_girl_rails'
describe "SearchFilesPages" do
	    let (:user) {FactoryGirl.create(:user, :name => "vandung")}
  	  let(:folder){FactoryGirl.create(:folder)}
      let(:filestream){FactoryGirl.create(:filestream)}
	    before do
	  		sign_in user
	  		@category = Category.new(:name => "Category", :description => "Description")
	  		@category.save!
	    end
		  describe "search files" do

		    before do
	    	 @file = folder.filestreams.build(folder_id:folder.id, attach_file_name:"bench_with_sea_view_sunset-wallpaper-1366x768.jpg",attach_content_type:"image/jpeg", attach_file_size:"515184", :download_count =>0)
	    	 @file.save!
	      end
    	  describe "search files" do 
	    	  before do
				    visit ("/folders/" + @file.folder_id.to_s + "&?user_id=" + @file.user_id.to_s)
				    fill_in "search", with: "bench_with_sea_view_sunset-wallpaper-1366x768.jpg"
					    	# let(:search) { FactoryGirl.create(:search, keywords: "dung") }
				    click_button "Search"
				  end
				    it { should_not have_content('Count Download') }
				    it {should have_content('bench_with_sea_view_sunset-wallpaper-1366x768.jpg')}
				end
	   end
      
end
