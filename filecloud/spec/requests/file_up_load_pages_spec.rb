require 'spec_helper'

describe"FileUpLoad pages" do

subject{page}
let(:f){FactoryGirl.create(:folder)}
before do
		
		@file = FileUpLoad.new(:folder_id => 1, :attach => File.new(Rails.root + 'spec/phongcanh.jpeg'))
	    @file.save
	    
end
subject(@file)

 describe "new page" do
 	#before{visit new_file_up_load_path}
#it{should have_selector('h1',text:"UpLoadFile #{f.name}")}

it "upload file to server" do
  attach_file(@file.attach, Rails.root + 'spec/phongcanh.jpeg')
  click_button 'Up File'
end
it"Upload file success"

it{should have_link('Back',href:folder_path(f.id))}
end

end