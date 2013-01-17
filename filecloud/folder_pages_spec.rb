require 'spec_helper'

describe "Folder pages" do
	subject{page}
    let(:category){FactoryGirl.create(:category)}
    before do
    	 @folder=category.folders.build(name:"Example Folder",category_id:category.id,description:"This is Example Folder")
    	 @folder.save
    	end

	describe "show page" do
       before { visit folder_path(@folder)}

       it {should have_selector('h1',text:@folder.name)}
       it {should have_selector('title',text:@folder.name)}
       it {should have_link(category.name ,href:category_path(category.id))}


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

    it {should have_link('Back',href:folders_path)}

    describe "with invalid information" do
     it "should not create a category" do
      expect {click_button submit}.not_to change(Folder,:count)
    end
   end

   describe "with valid information" do
     before do
      fill_in "Name",   with:"Example Folder"
      fill_in "category_id", with:category_id
      fill_in "Description", with:"This Example Folder"
     end
        it "should create a new folder" do
        expect{click_button submit}.to change(Folder,:count).by(1)
       end
   end
end

  describe "edit page" do

     before{visit edit_folder_path(@folder)}

     it {should have_selector('h1',text:"Edit Folder Detail")}
     it {should have_selector('title',text:@folder.name)}


         describe "with valid information" do
           let(:new_name){"New Folder"}
           let(:new_description){"This is Folder"}
           before do
            fill_in "Name",with:new_name
            @folder.category_id=category.id
            fill_in "Description",with:new_description
            click_button "Save change"
           end
          specify{@folder.reload.name.should== new_name}

          specify {@folder.reload.description.should==new_description}

         end


     describe "with invalid information" do
     before do
       fill_in "Name",with:""
       @folder.category_id=nil
       fill_in "Description",with:""
      click_button "Save change"
       end

     it{should have_content ('error')}
     end

     it {should have_link('Back',href:folders_path)}
  end

end
