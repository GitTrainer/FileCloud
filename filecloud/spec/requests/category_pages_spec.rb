  require 'spec_helper'

describe "Category pages" do
   subject{page}
   let(:category){FactoryGirl.create(:category)}

   describe "show page" do
   	
    before { visit category_path(category)}

     	 it {should have_selector('h1',text:category.name)}
       it {should have_selector('title',text:category.name)}

     it "should list folders" do
      category.folders.each do |f|
          page.should have_selector('li',text:f.name)
          page.should have_link(f.name,href:folder_path(f.id))
      end
     end
     
     it {should have_link('Back',href:categories_path)}
   end

   describe "new page" do

    before{visit new_category_path}

    let(:submit){"Create Category"}

    describe "with invalid information" do
      before do
        fill_in "Name", :with=>""
        fill_in "Description",:with=>""
      end
     it "should not create a category" do
     	expect {click_button submit}.not_to change(Category,:count)
    end
   end

   describe "with valid information" do
     before do
      fill_in "Name",   with:"Example Category"
      fill_in "Description", with:"This Example Category"
     end
        it "should create a new category" do
         expect{click_button submit}.to change(Category,:count).by(1)
       end
   end

    it {should have_link('Back',href:categories_path)}
end
 
	describe "edit page" do
		 
		 before{visit edit_category_path(category)}

		 it {should have_selector('h1',text:"Edit Category Detail")}
		 it {should have_selector('title',text:category.name)}
     

         describe "with valid information" do
           let(:new_name){"New Category"}
           let(:new_description){"This is New Category"}
           before do
           	fill_in "Name",with:new_name
           	fill_in "Description",with:new_description
            click_button "Save change"
           end
          specify{category.reload.name.should== new_name}
          specify {category.reload.description.should==new_description}

         end


		 describe "with invalid information" do

		 	before do
            fill_in "Name",with:""
            fill_in "Description",with:""
        click_button "Save change"
      end

     it { should have_content('Errors') }
		 end

     it {should have_link('Back',href:categories_path)}  
	end

   describe "index page" do
    
    before do 
      
      FactoryGirl.create(:category,name:"Category1",description:"This is Category1")
      FactoryGirl.create(:category,name:"Category2",description:"This is Category2")
      visit categories_path
     end
    it{should have_selector('h1',text:"List Category")}
    it{should have_selector('title',text:"Categories")}
    
    
    it "should list category"  do
     Category.all.each do|c|
    
     page.should have_link(c.name,href:category_path(c.id))
     page.should have_link('Edit',href:edit_category_path(c.id))
     page.should have_link('Delete',href:category_path(c)) do
      expect{click_link "Delete"}.to change(Category,:count).by(-1)
      end
     end
    end
   it {should have_link('Add new Category',href:new_category_path)}
   end

end
