# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :folder do
    category_id 1
    name "MyString"
    description "MyText"
  end
end
