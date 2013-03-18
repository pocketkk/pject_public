require 'spec_helper'

  feature "User Sessions" do

    scenario "Part is added to list" do
        @user = FactoryGirl.create(:user)
        add_part("My New Part")
        page.should have_content("My New Part")
    end

    scenario "Part doesn't show link for remove if not admin" do
        @user = FactoryGirl.create(:user)
        add_part("Newest Part")
        page.should have_content("Newest Part")
        page.has_no_link?("Remove")
    end

    scenario "Part shows remove link for admin" do
        @user= FactoryGirl.create(:admin)
        add_part("Admin Part")
        page.should have_content("Admin Part")
        page.has_link?("Remove")
    end



end
