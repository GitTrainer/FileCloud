FactoryGirl.define do
	factory :user do
		name "KhanhHoang"
		email "dangkhanhjava@gmail.com"
		password "1234567"
		password_confirmation "1234567"
	end

	factory :user_activated ,class: User do
		name "kunyokug"
		email "kunyokug@gmail.com"
		password "1234567"
		password_confirmation "1234567"
		status true
	end

	factory :user_admin ,class: User do
		name "kunyokug"
		email "user@yahoo.com"
		password "1234567"
		password_confirmation "1234567"
		status true
      	admin true
	end
end