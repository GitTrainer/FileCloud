FactoryGirl.define do 
	factory :category do
		name "Example Category"
		description "This Example Category"
	end

	factory :folder do
		name "Example Folder"
		description "this Example Folder"
		category
	end
	factory :file_up_load do
		attach_file_name "File Name"
		attach_content_type "image/jpeg"
		attach_file_size '254'
		folder 
	end
end