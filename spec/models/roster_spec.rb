require 'spec_helper'

describe 'roster' do

  it "should return a roster of users assigned to a branch" do
    user=Factory.create(:user, current_branch: 350)
    user2=Factory.create(:user, current_branch: 350)
    user3=Factory.create(:user, current_branch: 350)

    roster=Roster.new(user)
    roster.users.count.should == 3
  end

  it "should return a roster of users assigned to multiple branches" do
    user=Factory.create(:user, current_branch: 350)
    user2=Factory.create(:user, current_branch: 350)
    user3=Factory.create(:user, current_branch: 340)
    user.add_branch(340)
    roster=Roster.new(user)
    roster.users.count.should == 3
  end

  it "should not include inactive users" do
    user=Factory.create(:user)
    user2=Factory.create(:user, active: false)
    roster=Roster.new(user).users.count.should == 1
  end

end
