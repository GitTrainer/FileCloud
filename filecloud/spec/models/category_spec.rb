    require 'spec_helper'

describe Category do
	before do
		@category=Category.new(name:"Example Category",description:"This Example Category") 
	  end
	subject{@category}

	it {should respond_to(:name)} #kiem tra su ton tai cua thuoc tinhname
	it {should respond_to(:description)} #kiem tra su ton tai cua thuoc tinhdescription
    it { should respond_to(:folders) }
     it {should be_valid} #kiem tra su hien dien cua name

    describe "when name is not present" do
    before {@category.name=""} #trong truong hop ten la khoang trong thi ko hop le
    it{should_not be_valid}
    end 

    describe "when name is too long" do  #trong truong hop name dai qua 50 ky tu
    	before {@category.name="a"*51}
        it {should_not be_valid}
    end

    describe "when name is too short" do
       before{@category.name="a"}
       it {should_not be_valid}
    end

    describe "when name is already taken" do  #khi ten category da ton tai
     before do

     category_with_same_name=@category.dup
     category_with_same_name.save
     end
     it {should_not be_valid}
    end
end
