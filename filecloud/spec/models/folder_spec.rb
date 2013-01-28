  require 'spec_helper'

describe Folder do 
 let(:category){FactoryGirl.create(:category)}
 
	before do
	@folder=category.folders.build(name:"New Example Folder1",description:"New this Example Folder1")
  @folder.save
	end
	subject{@folder}
	
	it {should respond_to(:name)}
	it {should respond_to(:category_id)}
	it {should respond_to(:description)}
  it { should respond_to(:category) }
  its(:category) { should == category }

  it { should be_valid }

    describe "when name is not present" do
     before {@folder.name=""}
     it {should_not be_valid} 	
    end

    describe "when category_id is not present" do
    before{@folder.category_id=nil}
    it{should_not be_valid}
    end

    describe "when name is too length" do
    before{@folder.name="a"*51}
    it {should_not be_valid}
    end
    
    describe "when name is too short" do
       before{@folder.name="a"}
       it {should_not be_valid}
    end
end