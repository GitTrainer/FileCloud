# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :filestream do
    filename "MyString"
    folder_id 4
    attach_file_name "bench_with_sea_view_sunset-wallpaper-1366x768.jpg"
    attach_file_size "515184"
    attach_content_type "image/jpeg"
  end


  factory :filestream1 do
    filename "MyString"
    folder_id 4
    attach_file_name "anh5.JPG"
    attach_file_size "5835193"
    attach_content_type "image/jpeg"
    created_at "01/29/2013"
  end
	factory :filestream2 do
	    filename "MyString"
	    folder_id 4
	    attach_file_name "chieu.jpg"
	    attach_file_size "151516"
	    attach_content_type "image/jpeg"
	    created_at "01/30/2013"
	end

  factory :filestreams , class: Filestream do
    filename "MyString"
    folder_id 2
    attach_file_name "chieu.jpeg"
    attach_content_type "image/jpeg"
    attach_file_size "151516"
    folder
  end

#  factory :filestream1, class: Filestream do
#    filename "MyString"
#    folder_id 4
#    attach_file_name "anh5.JPG"
#    attach_file_size "5835193"
#    attach_content_type "image/jpeg"
#    created_at "01/29/2013"
#  end


#	factory :filestream2, class: Filestream do
#		filename "MyString"
#		folder_id 4
#		attach_file_name "chieu.jpg"
#		attach_file_size "151516"
#		attach_content_type "image/jpeg"
#		created_at "01/30/2013"
#	end

#  factory :filestreams , class: Filestream do
#    filename "MyString"
#    folder_id 2
#    attach_file_name "chieu.jpeg"
#    attach_content_type "image/jpeg"
#    attach_file_size "151516"
#    folder
#  end


end
