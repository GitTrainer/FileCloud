require 'spec_helper'


describe Category do
  
	before { @Category=Category.new(name: "Picture",description: "This is picture.") }

	subject{ @Category }

	it { should respond_to(:name) }
	it { should respond_to(:description) }
	it { should be_valid }

	describe "When name is not present."	do
		before { @Category.name="" }
		it { should_not be_valid }
	end

	describe "when description is not present" do
		before { @Category.description="" }
		it { should_not be_valid }
	end

	describe "when name is too long" do 
		before { @Category.name="a"*52 }
		it { should_not be_valid }
	end

	describe "when name is already take" do
		before do 
			category_with_same_name=@Category.dup
			category_with_same_name.save
		end
		it { should_not be_valid }
	end

end
