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


end
