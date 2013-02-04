FactoryGirl.define do
	
	factory :user do
		name "KhanhHoang"
		email "dangkhanhit@gmail.com"
		password "1234567"
		password_confirmation "1234567"
		status true
	end

	factory :user3 ,class: User do
		name "KhanhHoang"
		email "user3@gmail.com"
		password "1234567"
		password_confirmation "1234567"
	end

	factory :user_activated ,class: User do
		name "kunyokug"
		email "dangkhanhjava@gmail.com"
		password "1234567"
		password_confirmation "1234567"
		status true
	end

	factory :user_admin ,class: User do
		name "kunyokug"
		email "test@yahoo.com"
		password "1234567"
		password_confirmation "1234567"
		status true
		admin true
	end

	factory :category do
		name "Example Category"
		description "This Example Category"
	end

	factory :folder do
		name "Example Folder"
		description "this Example Folder"
		category
		user
	end

	factory :file_up_load do
		attach_file_name "File Name"
		attach_content_type "image/jpeg"
		attach_file_size "234"
		folder 
	end

	factory :fileshare do 
        user
        file_up_load
	end
end