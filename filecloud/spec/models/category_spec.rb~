require 'spec_helper'
require 'shoulda-matchers'
describe Category do
  before do
      @category = Category.new(:name => "Bongda", :description => "Football")
  end

  subject { @category }

  it { should respond_to(:name)}
  it { should respond_to(:description)}
   it { should respond_to(:folders) }
  it { should be_valid  }

  describe "when name is not presence" do
     before {@category.name = " "}
     it { should_not be_valid }
  end
  describe "when description is not presence" do
     before {@category.description = " "}
     it { should_not be_valid }
  end
  describe "when name has been taken" do
	before do
		new_cat = @category.dup
		new_cat.save
	end
	 it { should_not be_valid }
  end
end
