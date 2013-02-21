FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'framgiatest@gmail.com'
    password 'framgia@123456'
    password_confirmation 'framgia@123456'
    # view email confirm at the
    confirmed_at Time.now
  end
end