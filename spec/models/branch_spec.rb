require 'spec_helper'

describe 'branch' do

  it 'should only allow each user to have each branch once' do
    user = FactoryGirl.create(:user)
    4.times do
      user.add_branch(300)
    end
    user.branches.count.should == 2
  end


end
