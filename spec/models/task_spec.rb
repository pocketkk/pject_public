require 'spec_helper'

describe Task do

  before(:each) do
    @task=Factory.create(:task)
  end

  it "has valid factory" do
    @task.class.name.should=="Task"
  end

  it "should belong to user" do
    @task.taskable.class.name.should=="User"
  end

  it "should be able to have followers assigned" do
    user1=Factory.create(:user)
    user2=Factory.create(:user)
    task=Factory.build(:task, followers_for: [user1.id, user2.id])
    task.save
    task.followers.count.should==2
  end

  it "should be able to remove followers assigned" do
    user1=Factory.create(:user)
    user2=Factory.create(:user)
    task=Factory.build(:task, followers_for: [user1.id, user2.id])
    task.save
    task.followers.count.should ==2
    task.followers_for=([user2.id])
    task.save
    updated_task=Task.find(task.id)
    updated_task.followers.count.should==1
  end

end
