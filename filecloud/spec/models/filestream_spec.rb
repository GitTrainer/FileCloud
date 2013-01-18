require 'spec_helper'
require 'shoulda-matchers'
describe Filestream do
	before do
		@file = Filestream.new(:folder_id => 1, :attach => File.new(Rails.root + 'spec/night_panorama-wallpaper-1280x720.jpg'))
	end

	 subject { @file }
	it {should respond_to(:folder_id)}
	it {should respond_to(:attach)}

	it { should be_valid  }

	describe "when folder_id is not present" do
    before { @file.folder_id = " " }
    it { should_not be_valid }
  end

  describe "when attach file is not present" do
    before { @file.attach = nil }
    it { should_not be_valid }
  end

end
