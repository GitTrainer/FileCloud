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

	factory :newuser, class: User do
			name "Hoang Mai Nhi"
			email "mainhi@gmail.com"
			password "123456"
			password_confirmation "123456"
			status true
	end

	factory :fakeuser, class: User do
			name "Test User"
			email "testuser@gmail.com"
			password "123456"
			password_confirmation "123456"
			status true
	end

end
