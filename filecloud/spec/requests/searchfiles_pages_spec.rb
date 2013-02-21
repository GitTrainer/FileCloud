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
	    	 @file1 = folder.filestreams.build(folder_id:folder.id, attach_file_name:"bench_with_sea_view_sunset-wallpaper-1366x768.jpg",attach_content_type:"image/jpeg", attach_file_size:"515184", :download_count =>0)
	    	 @file1.save!
	    	  @file2 = folder.filestreams.build(folder_id:folder.id, attach_file_name:"dung.jpg",attach_content_type:"image/jpeg", attach_file_size:"515184", :download_count =>0)
	    	 @file2.save!
	    	  @file3 = folder.filestreams.build(folder_id:folder.id, attach_file_name:"hung.jpg",attach_content_type:"image/jpeg", attach_file_size:"515184", :download_count =>0)
	    	 @file3.save!
	    	end
    	  describe "search files" do
			    before do
			    	visit '/folders/'+@file1.folder_id.to_s+'&?user_id='+user.id.to_s
			    	# fill_in "dung", with: "down_arrrow"
			    	# click_button "Search"
			    end
			    it {save_and_open_page}
			    it { should_not have_content('Count Download') }
			    it {should have_content('dung')}
			  end
	    end
      # describe "filestream name has a higher weight than filestream description" do
      #   let(:search) { FactoryGirl.create(:search, keywords: "dung") }
		    # it { should include(@file1) }     # passes
	     #  it { should include(@file2) }    # passes
	     #  it { should_not include(@file3) } # passes
	     #  it { should == [@file1, @file2] } # passes
	     #  it { should == [@file2, @file1] } # passes (?!?)
	     #  it { should == [@file1, @file2, @file3] } # fails 
	     #  it { should == [] } # passes (!) 
	     #  specify { subject.count.should == 2 }   # fails => got 0
	     #  specify { subject.count.should eq(2) } # fails => got 0
	     #  it { should == [@file1, @file2] } 
		    # it { should_not == [@file2, @file1] } 
		    # it { should include(@file1) }     
		    # it { should include(@file1) }     
		    # it { should include(@file2) }    
		    # it { should_not include(@file3) } 
		    # it { should have(2).items } 
  		# end 

end
