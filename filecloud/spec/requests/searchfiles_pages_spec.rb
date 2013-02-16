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
			    	visit '/folders/'+@file.folder_id.to_s+'&?user_id='+user.id.to_s
			    end
			    it {save_and_open_page}
			    it { should_not have_content('Count Download') }
			  end
	
    describe "filestream name has a higher weight than filestream description" do
    
	      
	      
	      let(:search) { FactoryGirl.create(:search, keywords: "searched keywords") }
		
      # it { should include(category_first) }     # passes
      # it { should include(category_second) }    # passes
      # it { should_not include(category_third) } # passes

      # it { should == [category_first, category_second] } # passes
      # it { should == [category_second, category_first] } # passes (?!?)
      # it { should == [category_first, category_second, category_third] } # fails 
      # it { should == [] } # passes (!) 
  		it {save_and_open_page}
      # specify { subject.count.should == 2 }   # fails => got 0
      # specify { subject.count.should eq(2) } # fails => got 0
        it { should == [@file1, @file2] } 
	    it { should_not == [@file2, @file1] } 
	    it { should include(@file1) }     
	    it { should include(@file1) }     
	    it { should include(@file2) }    
	    it { should_not include(@file3) } 
	    it { should have(2).items } 
  end 
end
end
