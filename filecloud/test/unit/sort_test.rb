require 'test_helper'

describe "SortPages" do
	describe "sort name ASC" do
		name_one=Filestream.create attach_file_name: "dung"
		name_two=Filestream.create attach_file_name: "chieu"
		assert Filestream.all.index(name_one) < Filestream.all.index(name_two)
	end
end