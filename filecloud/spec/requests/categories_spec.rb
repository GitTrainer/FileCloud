require 'spec_helper'
require 'factory_girl_rails'
require 'factory_girl'
describe "Categories" do
let (:user) {FactoryGirl.create(:user)}
before do
  sign_in user

end
 # it {save_and_open_page}
  subject { page }
  	describe "Category index page" do
  		before { visit '/categories'}
  	  	it "Should has a Edit link" do
  		  page.should have_content 'Edit'
  		end
  		it "Should has a Show link" do
  		  page.should have_content 'Show'
  		end
  		it "Should has a Delete link" do
  		  page.should have_content ('Delete')
  		end
  	end

  	describe "Create category" do
  	   before { visit '/categories'}
         let(:submit) { "Create Category" }

  		describe "with valid information" do
  			before do
  				fill_in 'Name', :with => "News"
  				fill_in 'Description', :with => "Information"
  			end
  			it "Should create a category" do
  				 expect{click_button submit}.to change(Category,:count).by(1)
  			end
  			describe "after saving the category" do
          		before { click_button submit }
          		let(:category) { Category.find_by_name('News') }
          		it { should have_selector('table', value: "News") }
          		it { should have_selector('table', value: "Information") }
       		    end
  			end

  	  describe "with invalid information" do
      	  it "should not create a category" do
         	  expect { click_button submit }.not_to change(Category, :count)
            end
        end
      end

  	describe "Edit category" do
         let(:category) { FactoryGirl.create(:category) }
     	   before { visit edit_category_path(category) }
         describe "page" do
           it { should have_content(category.name) }
           it { should have_content(category.description) }
           it { should have_selector('input', value: "Update Category") }
         end

         describe "with invalid information" do
           before { click_button "Update Category" }
           it { should have_selector('input', value: "Update Category") }
         end
         describe "with valid information" do
        let(:new_name)  { "New Name" }
        let(:new_description) { "New Description" }
        before do
          fill_in "Name",             with: new_name
          fill_in "category_description",      with: new_description
          click_button "Update Category"
        end

        it { should have_selector('table', text: new_name) }
        it { should have_selector('table', text: new_description) }
        it { should have_link('Create folder', href: folders_path) }
        specify { category.reload.name.should  == new_name }
        specify { category.reload.description.should == new_description }
      end
  	end

  	describe "Show category" do
  		 let(:category) { FactoryGirl.create(:category) }
     	     before { visit category_path(category) }
     	      describe "page" do
           it { should have_content(category.name) }
           it { should have_content(category.description) }
           it { should have_content("List folders")}
         end
  	end


   describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the category page" do
          before { visit '/categories' }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { visit '/categories' }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end

  end
