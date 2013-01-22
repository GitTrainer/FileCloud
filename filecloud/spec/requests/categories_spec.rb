require 'spec_helper'

describe "Categories" do
  subject { page }
  let(:categories) { FactoryGirl.create(:categories) }
  describe "Categories index page" do
  	before { visit '/categories'}
  	it "Should has a edit link" do
  		page.should have_content 'Edit'
  	end
  	it "Should has a show link" do
  		page.should have_content 'Show'
  	end
  	it "Should has a Destroy link" do
  		page.should have_content 'Destroy'
  	end
  end

  describe "Create categories" do
  	before { visit '/categories' }
  	# let (:Category) {FactoryGirl.create(:categories)}
           let(:submit) { "New Category" }

    describe "with invalid information" do
      it "should not create a categories" do
        expect { click_link ('New Category') }.not_to change(Category, :count)
      end
    end

    describe "with valid information" do
      before do         
         fill_in "Name" ,       with: "Category one"
         fill_in "Description" ,   with:"This is category one."        
      end  
          it "should create a category" do
 # expect { click_link ('New Category') }.to change(Category,:count).by(1)
 expect { click_button submit }.to change(User, :count).by(1)

          end
      
      
    end
  end

  describe "Should category" do
    let(:category) { FactoryGirl.create(:category) }
    before { visit category_path(category) }
      describe "in page" do
        it { should have_content(category.name) }
        it { should have_content(category.description) }
        # it { should have_link('Back',href:category_path) }

      end
  end

  describe "Edit category" do
    let(:category) { FactoryGirl.create(:category) }
    before { visit edit_category_path(category) }
    describe "page" do
         it { should have_content(category.name) }
         it { should have_content(category.description) }
         it { should have_link('Back', href:categories_path) }

       end
  end
end
