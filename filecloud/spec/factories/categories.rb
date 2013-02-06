# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category, class: Category do
    name "MyString"
    description "MyString"
  end
end
