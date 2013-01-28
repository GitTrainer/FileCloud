require 'spec_helper'

describe "Folder pages" do
	subject{page}
    let(:category){FactoryGirl.create(:category)}
    let(:category_second){FactoryGirl.create(name:"Category second",description:"This is Category second")}
    before do
    	 @folder=category.folders.build(name:"Example Folder1",category_id:category.id,description:"This is Example Folder1")
    	 @folder.save
    	end

	describe "show page" do
       before { visit folder_path(@folder.id)}

       it {should have_selector('h1',text:@folder.name)}
       it {should have_selector('title',text:@folder.name)}
      
      it "should list files in this folder" do
      @folder.file_up_loads.each do |f|
      page.should have_selector('td',text:f.attach_file_name)
      page.should have_selector('td',text:f.attach_content_type)
      page.should have_selector('td',text:f.attach_file_size)
      page.should have_selector('td',text:f.created_at)
      page.should have_link('Download File',download_file_up_load_path(f.id))
      it "should delete a File" do
           expect { click_link('Delete') }.to change(FileUpLoad, :count).by(-1)
         end

      end
     end
    
      it {should have_link('Back',href:folders_path)}
      
	end

   describe "new page" do

    before{visit new_folder_path}

    let(:submit){"Create Folder"}

   
    describe "with invalid information" do
      before do
       fill_in "Name",with:""
       fill_in "Description",with:""
       click_button submit
       end

     it{should have_content ('Errors')} 
     it "should not create a category" do
      expect {click_button submit}.not_to change(Folder,:count)
    end
   end

   describe "with valid information" do
     before do
      fill_in "Name",   with:"Example Folder"
      select category.name, :from=>'folder_category_id'
      fill_in "Description", with:"This Example Folder"
     end

        it "should create a new folder" do
        expect{click_button submit}.to change(Folder,:count).by(1)
       end
   end
   

end

  describe "edit page" do
    
     before{visit edit_folder_path(@folder.id)}

     it {should have_selector('h1',text:"Edit Folder Detail")}
     it {should have_selector('title',text:@folder.name)}
    

         describe "with valid information" do
           let(:new_name){"New Folder"}
           let(:new_description){"This is Folder"}
           before do
            fill_in "Name",with:new_name
            select category.name, :from=>'folder_category_id'
           
            fill_in "Description",with:new_description
            click_button "Save change"
           end
          specify{@folder.reload.name.should== new_name}
          
          specify {@folder.reload.description.should==new_description}

         end


     describe "with invalid information" do
     before do
       fill_in "Name",with:""
       click_button "Save change"
       end

     it{should have_content ('Errors')}
     end

     it {should have_link('Back',href:folderolder_path(@folder.id))} 
  end

   describe "index page" do

    before do 
     
      FactoryGirl.create(:folder,:name=>"Folder1",:category_id=>1,:description=>"This is Folder1")
      FactoryGirl.create(:folder,:name=>"Folder2",:category_id=>1,:description=>"This is Folder2")
      visit folders_path
    end

    it{should have_selector('h1',text:"List Folder")}
    it{should have_selector('title',text:"Folders")}
    
    
    it"should list folder "  do
     Folder.all.each do|f|
     page.should have_selector('li',text:f.name)
     page.should have_link('Edit',href:edit_folder_path(f.id))
     page.should have_link('Delete',href:folder_path(f)) do
           expect { click_link('Delete') }.to change(Folder, :count).by(-1)
         end
     end
    end
   it {should have_link('Create new folder',href:new_folder_path)}
   end

end