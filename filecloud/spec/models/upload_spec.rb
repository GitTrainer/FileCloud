require 'spec_helper'

describe Upload do
  before do
  	@file = Upload.new(:folder_id => 1,:upload => File.new(Rails.root + 'spec/girl.jpg'))
  	@file.save
  end

  subject{ @file }
  it { should respond_to(:folder_id) }
  it { should respond_to(:upload) }

  it { should be_valid }

  describe "when upload file is not empty" do
	  before { @file.upload = nil }
	  it { should_not be_valid }
	end

  describe "when folder_id is not empty." do
	  before { @file.folder_id = "" }
	  it { should_not be_valid }
  end
end
