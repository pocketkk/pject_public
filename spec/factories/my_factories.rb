include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    name     "Robot Tester"
    sequence(:email) { |n| "email#{n}@test.com"}
    password "foobar"
    password_confirmation "foobar"
    role "Sales"
    current_branch 350
    admin false

    factory :admin do
        admin true
    end
  end

  factory :asset do
    name "A4"
    serial "1234"
    status 0
    ready false
    workorder
  end

  factory :workorder do
    customer "Restaurant Name"
    street "1234 Address"
    city "Oakland"
    state "CA"
    phonenumber "9255557867"
    contact "James"
    misc_notes "Park in the back"
    wo_type "New Install"
    wo_duration 1
    user
    branch 350
    completed false

    factory :pastdue_workorder do
        wo_date Time.now - 5.days
    end

    factory :duetoday_workorder do
        chronic_wo_date "today"
    end

    factory :notdue_workorder do
        wo_date Time.now + 5.days
    end

    factory :miscnotes_workorder do
        misc_notes "This note has more than two hundred characters.  It will
        be hard to tell when it exceeds two hundred though because i don't know
        how to count that high.  Oh well good luck with the long misc notes.  I
        started counting and it looks like I need an additional two lines to make
        sure I exceed 200 characters"
    end

    factory :invalid_workorder do
        customer=nil
    end

    # factory :workorder_with_asset do
    #     after(:create) do |workorder|
    #         FactoryGirl.create(:asset, workorder: workorder)
    #     end
    # end

  end

  factory :before_photo do
    photo { fixture_file_upload(Rails.root.join('public', 'dgrey076.jpg'), 'image/jpg') }
    workorder
  end

  factory :after_photo do
    photo { fixture_file_upload(Rails.root.join('public', 'dgrey076.jpg'), 'image/jpg') }
    workorder
  end

  factory :part do
    sequence(:name) { |n| "Part#{n} Name"}
    qty 10
    ordered false
    po_number 1234
    comment "Describes the part"
    user
  end

  factory :document do
    sequence(:description) { |n| "Document#{n}" }
    pdfdoc { File.open(Rails.root.join('public', 'image.pdf')) }
  end


end
