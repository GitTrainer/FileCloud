require 'spec_helper'
require 'factory_girl'
require 'factory_girl_rails'
describe "SearchPages" do
	let (:user) {FactoryGirl.create(:user, :name => "vandung")}
	subject { page }
	before do
		sign_in user
		
		let(:category_first)   { FactoryGirl.create(:category, name: 'searched keywords', description: "unmatching") }
		@category.save!
		let(:category_second)  { FactoryGirl.create(:category, name: 'unmatching', description: "searched keywords") } 
		@category.save!
		let(:category_third)   { FactoryGirl.create(:category, name: 'unmatching', description: "unmatching") } 
		@category.save!
	end
    describe "category name has a higher weight than category description" do
    
	      
	      
	      let(:search) { FactoryGirl.create(:search, keywords: "searched keywords") }
		
      # it { should include(category_first) }     # passes
      # it { should include(category_second) }    # passes
      # it { should_not include(category_third) } # passes

      # it { should == [category_first, category_second] } # passes
      # it { should == [category_second, category_first] } # passes (?!?)
      # it { should == [category_first, category_second, category_third] } # fails 
      # it { should == [] } # passes (!) 
  		it {save_and_open_page}
      # specify { subject.count.should == 2 }   # fails => got 0
      # specify { subject.count.should eq(2) } # fails => got 0
        it { should == [category_first, category_second] } # passes
	    it { should_not == [category_second, category_first] } # passes 
	    it { should include(category_first) }     # passes
	    it { should include(category_first) }     # passes
	    it { should include(category_second) }    # passes
	    it { should_not include(category_third) } # passes
	    it { should have(2).items } 
  end 
end
