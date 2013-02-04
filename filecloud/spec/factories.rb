FactoryGirl.define do
	factory :user do
		name "vandung"
		email "ngvandung2010@gmail.com"
		password "123456"
		password_confirmation "123456"
		status true
	factory :admin do
		admin true
	end
	end

	# factory :filestream do
	# 	filename "MyString"
	# 	attach_file_name "chieu.jpeg"
	# 	attach_content_type "image/jpeg"
	# 	attach_file_size "151516"
	# 	folder
	# end


end
