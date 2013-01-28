    require 'spec_helper'

describe Category do
	before do
		@category=Category.new(name:"Example Category",description:"This Example Category") 
	  end
	subject{@category}

	it {should respond_to(:name)} 
	it {should respond_to(:description)}
    it { should respond_to(:folders) }
     it {should be_valid} 

    describe "when name is not present" do
    before {@category.name=""} 
    it{should_not be_valid}
    end 

    describe "when name is too long" do 
    	before {@category.name="a"*51}
        it {should_not be_valid}
    end

    describe "when name is too short" do
       before{@category.name="a"}
       it {should_not be_valid}
    end

    describe "when name is already taken" do 
     before do

     category_with_same_name=@category.dup
     category_with_same_name.save
     end
     it {should_not be_valid}
    end
end
