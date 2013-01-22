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
  	let (:Category) {FactoryGirl.create(:categories)}

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
      #   it "Should create a category" do
      #   expect{ click_link ('New Category') }.to change(Category,:count).by(1)
      #   it { should have_link('Back', href: categories_path) }
      # end
    end
  end
end
