require 'spec_helper'

require 'factory_girl'

describe Folder do
	let(:category) { FactoryGirl.create(:category) }
  before { @Folder=Folder.new(name:"Folder one",description:"This is folder one.") }

  subject { @Folder }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
   it { should respond_to(:category_id) }
   it { should respond_to(:category) }
   its(:category) { should == category }
   it { should be_valid }

  describe "When name is not present." do
  	before { @Folder.name="" }
  	it { should_not be_valid }
  end

  describe "when name is already take"do
  	before do
  		folder_with_same_name = @Folder.dup
  		folder_with_same_name.save
  	end
  end

  describe "When description is not present." do
  	before { @Folder.description="" }
  	it { should_not be_valid }
  end

  describe "when category_id is not nil" do
  	before { @Folder.category_id=nil }
  	it { should_not be_valid }
  end

  describe "when category_id is not present." do
  	before { @Folder.category_id="" }
  	it { should_not be_valid }
  end

end
