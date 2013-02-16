require 'spec_helper'
require 'factory_girl'
require 'factory_girl_rails'
describe "CounterPages" do
  let (:user) {FactoryGirl.create(:user, :name => "vandung")}
  	
	let(:folder){FactoryGirl.create(:folder)}
  let(:filestream){FactoryGirl.create(:filestream)}
	before do
  		sign_in user
  		@category = Category.new(:name => "Category", :description => "Description")
  		@category.save!
	end
		describe "Counter download" do

	    before do
    	 @file = folder.filestreams.build(folder_id:folder.id, attach_file_name:"bench_with_sea_view_sunset-wallpaper-1366x768.jpg",attach_content_type:"image/jpeg", attach_file_size:"515184", :download_count =>0)
    	 @file.save!
    	end

		    describe "count download" do
	  			describe "cout download" do
				    before do
				    	visit '/folders/'+@file.folder_id.to_s+'&?user_id='+user.id.to_s
				    end
				    it {save_and_open_page}
				    it { should_not have_content('Count Download') }
				  end
				  describe "click Download" do
					  before do
					    visit '/folders/'+@file.folder_id.to_s+'&?user_id='+user.id.to_s
					    click_link "Download"
					  end
					    it { should_not have_content('0') }
				     	# click_link 'Download'.to change(Filestream,:count).by(1)
							# expect {click_link 'Download'}.to change(Filestream.download_count,:count).by(1)
						it { page.should change(Filestream.download_count, :count).by(1) }
					end
				end
	end
end
