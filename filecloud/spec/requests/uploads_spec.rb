require 'spec_helper'

describe "Uploads" do
	subject{page}
	let(:folder){FactoryGirl.create(:folder)}
	let(:upload){FactoryGirl.create(:upload)}

	before do
    	 @file = folder.uploads.build(folder_id:folder.id, upload_file_name:"girl.jpg")
    	 @file.save!
    end

    describe "page index" do
    	before {visit '/uploads/new?id='+folder.id.to_s}

    	it "should can All file " do
    		page.should have_selector('input', value:"Add file")
    	end
    	it "should can start upload" do
    		page.should have_selector('input', value:"Start upload")
    	end
    	it "should can Cancel upload" do 
    		page.should have_selector('input', value:"Cancel upload")
    	end
    	it "should can Delete upload" do 
    		page.should have_selector('input', value:"Delete")
    	end
    end
end