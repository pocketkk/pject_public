FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    sequence(:email) { |n| "email#{n}@test.com"}
    password "foobar"
    password_confirmation "foobar"
    role "Sales"
    current_branch "350"
    admin false
  end

  factory :workorder do
    customer "Restaurant Name"
    street "1234 Address"
    city "Oakland"
    state "CA"
    phonenumber "9254527867"
    contact "James"
    misc_notes "Park in the back"
    branch "350"
    wo_type "New Install"
  end
end
