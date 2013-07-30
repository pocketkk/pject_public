# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    content "MyText"
    taskable_id 1
    taskable_type "MyString"
    assigned_to 1
  end
end
