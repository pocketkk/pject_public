require File.dirname(__FILE__) + '/../spec_helper'

describe Updater do
  it "should be valid for workorders" do
    workorder = FactoryGirl.build(:workorder)
    Updater.new(workorder, update_type: :new)
    Update.last.feed_item.should == workorder.new_message
  end

  it "should use message option when supplied" do
    workorder = FactoryGirl.build(:workorder)
    Updater.new(workorder, update_type: :new, message: "Test")
    Update.last.feed_item.should == "Test"
  end

  it "should be valid for new users" do
    workorder = FactoryGirl.build(:workorder)
    Updater.new(workorder, update_type: :new)
    Update.last.feed_item.should == workorder.new_message
  end

  it "should be invalid without update_type" do
    workorder = FactoryGirl.build(:workorder)
    lambda{Updater.new(workorder)}.should raise_error
  end

  it "should create update for new users" do
    user = FactoryGirl.build(:user)
    user.save
    Update.last.feed_item.should == user.new_message
  end

  it "should create update for new blog posts" do
    user = FactoryGirl.build(:user)
    user.save
    post = user.posts.new
    post.title="Test"
    post.content="Test"
    post.save
    Update.last.feed_item.should == post.new_message
  end

  it "should create update for new parts" do
    user = FactoryGirl.build(:user)
    user.save
    part = user.parts.new
    part.name="Test"
    part.qty=30
    part.save
    Update.last.feed_item.should == part.new_message
  end

  it "should create update for ordered parts" do
    user = FactoryGirl.build(:user)
    user.save
    part = user.parts.new
    part.name="Test"
    part.qty=30
    part.save
    part.ordered!
    Update.last.feed_item.should == part.update_message
  end

  # it "should create update for new documents" do
  #   document=Document.new
  #   document.description = "Test"
  #   document.pdfdoc = File.open(Rails.root.join('public', 'image.pdf'))
  #   document.save
  #   Update.last.feed_item.should == document.new_message
  # end

  # it "should create update for new documents" do
  #   document=Document.new
  #   document.description = "Test"
  #   document.update_update
  #   Update.last.feed_item.should == document.update_message
  # end



end
