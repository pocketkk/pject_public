require 'spec_helper'

describe "Static Pages" do
  
  describe "Home" do
    it "should have the content 'Pject.us'" do
        visit '/static_pages/home'
        page.should have_selector('h1', :text => 'Pject.us')
    end
    it "should have the title 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('title', 
                    :text => "Pject.us | Home")
    end
  end

  describe "Help" do
    it "should have the content 'Help'" do
        visit '/static_pages/help'
        page.should have_selector('h1', :text => 'Help')
    end
      it "should have the title 'Help'" do
        visit '/static_pages/help'
        page.should have_selector('title' , 
                    :text => "Pject.us | Help")
    end
  end
  
  describe "About" do
    it "should have the content 'About'" do
        visit '/static_pages/about'
        page.should have_selector('h1',:text => 'About')
    end
    it "should have the title 'About'" do
        visit '/static_pages/about'
        page.should have_selector('title', 
                    :text => "Pject.us | About")
    end
  end
end
