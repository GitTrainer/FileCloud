# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :folder do
    name "MyString"
    description "MyString"
    category_id 1
    user_id 3
  end
end
