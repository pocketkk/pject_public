require 'spec_helper'

  feature "Mobile Static Pages" do

    scenario "Pastdue workorders count should equal all workorders due after today" do
        toggle_mobile
        @user = FactoryGirl.create(:user)
        2.times do
            FactoryGirl.create(:pastdue_workorder)
        end
        3.times do
            FactoryGirl.create(:notdue_workorder)
        end
        2.times do
            FactoryGirl.create(:duetoday_workorder)
        end
        sign_in(@user)
        visit root_path
        page.should have_content("2")
    end


end
