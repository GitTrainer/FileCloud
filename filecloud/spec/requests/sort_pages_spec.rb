require 'spec_helper'
require 'factory_girl'
require 'factory_girl_rails'
describe "SortPages" do
	
	let (:user) {FactoryGirl.create(:user)}
    let(:category){FactoryGirl.create(:category)}
	let(:folder){FactoryGirl.create(:folder)}
 	
	
	
     	before do
	    	 # @file1 = folder.filestreams.build(folder_id:folder.id, attach_file_name:"anh5.JPG",attach_content_type:"image/jpeg", attach_file_size:"5835193")
	    	 # @file2 = folder.filestreams.build(folder_id:folder.id, attach_file_name:"chieu.jpg",attach_content_type:"image/jpeg", attach_file_size:"151516")
    	  #  		visit '/folders/2&?direction=asc&sort=attach_file_name&user_id=current_user.id'
    	  sign_in user
    	  visit '/folders/'+folder.id.to_s+'&?user_id='+user.id.to_s
    	  visit '/filestreams/?folder_id='+folder.id.to_s
    	  attach_file('filestreams', "#{Rails.root}"+"/spec/up_arrrow.gif")
    	  click_button 'Start'
    	  visit '/filestreams/?folder_id='+folder.id.to_s
    	  attach_file('filestreams', "#{Rails.root}"+"/spec/down_arrrow.gif")
    	  click_button 'Start'

    	
    	end
    	describe "sort name ASC" do
    	# it {should have_selector('div#tablefolder')}

       	 	before do
       	 		visit '/folders/'+folder.id+'&?direction=asc&sort=attach_file_name&user_id='+user.id.to_s
            	# visit "/folders/#{folder.id}?direction=asc&sort=attach_file_name"
        	end
		        it {should have_selector('#tablefolder tr:nth-child(5) td:nth-child(4)',text:"up_arrow.gif")}
		        it {should have_selector('#tablefolder tr:nth-child(4) td:nth-child(4)',text:"down_arrow.gif")}
    	end
    	describe "sort name DESC" do
    	# it {should have_selector('div#tablefolder')}

       	 	before do
       	 		visit '/folders/'+folder.id+'&?direction=desc&sort=attach_file_name&user_id='+user.id.to_s
            	# visit "/folders/#{folder.id}?direction=asc&sort=attach_file_name"
        	end
		        it {should have_selector('#tablefolder tr:nth-child(4) td:nth-child(4)',text:"up_arrow.gif")}
		        it {should have_selector('#tablefolder tr:nth-child(5) td:nth-child(4)',text:"down_arrow.gif")}
    	end
    	describe "sort size desc" do
    		let{filestream1}
    	end

    	
    
# before { visit ('/filestreams/?folder_id='+ @file.folder_id.to_s)}







end
