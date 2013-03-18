require 'spec_helper'

  feature "User Sessions" do

    scenario "Home page loads when not logged in" do
      visit root_path
      click_link 'Sign In'
      current_path.should == signin_path
    end

    scenario "User signs in" do
        user = FactoryGirl.create(:user)
        visit root_path
        click_link 'Sign In'
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Sign in'
        visit root_path
        page.should have_content(user.name.titleize)
    end

    scenario "User signs out" do
        user = FactoryGirl.create(:user)
        sign_in(user)
        visit root_path
        page.should have_content(user.name.titleize)
        click_link "Sign out"
        page.should have_content("Sign In")
    end
  end

  feature "Mobile User Sessions" do

    scenario "Home page loads when not logged in" do
      visit root_path
      page.should have_content('Sign In')
    end

    scenario "User signs in on mobile device" do
        user = FactoryGirl.create(:user)
        toggle_mobile
        sign_in(user)
        page.should have_content(user.name.upcase)

    end

  end

