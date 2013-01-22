FactoryGirl.define do
	factory :user do
		name "KhanhHoang"
		email "dangkhanhit@gmail.com"
		password "1234567"
		password_confirmation "1234567"
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
end