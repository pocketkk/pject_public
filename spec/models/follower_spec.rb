require File.dirname(__FILE__) + '/../spec_helper'

describe Follower do

  before(:each) do
    @workorder = FactoryGirl.create(:workorder)
    @user1 = Factory.create(:user)
    @user2 = Factory.create(:user)
  end

  it "should be able to add followers" do
    expect {
        @workorder.add_follower(@user1)
    }.to change{@workorder.followers.count}.by(1)
  end

  it "should be able to remove followers" do
    @workorder.add_follower(@user1)
    expect {
        @workorder.remove_follower(@user1)
    }.to change{@workorder.followers.count}.by(-1)
  end

  it "should not add follower if already following" do
    @workorder.add_follower(@user1)
    expect {
        @workorder.add_follower(@user1)
        }.to change{@workorder.followers.count}.by(0)
  end

  it "should toggle follow" do
    expect { @workorder.toggle_follower(@user2) }.to change{@workorder.followers.count}.by(1)
    expect { @workorder.toggle_follower(@user2) }.to change{@workorder.followers.count}.by(-1)

  end

end
