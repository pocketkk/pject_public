require File.dirname(__FILE__) + '/../spec_helper'

describe DayOff do
  
  before(:each) do
    @lenny = Factory.create(:user)
    @vacation = Factory.create(:day_off, user: @lenny)
  end

  it "must have a start date" do
    expect { @lenny.day_offs.create! }.to raise_error(ActiveRecord::RecordInvalid)
  end
  
  it "must have an end date" do
    expect { @lenny.day_offs.create!(start_date: Date.today) }.to raise_error(ActiveRecord::RecordInvalid)
  end
  
  it "must have a type" do
    expect { @lenny.day_offs.create!(start_date: Date.today,
            end_date: Date.today + 1.day) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should calculate the number of days requested" do
    time_off=Factory.create(:day_off, start_date: Date.today + 1.days, end_date: Date.today + 4.days)
    time_off.num_days.should == 3
  end

  it "should email user when approved" do
    ActionMailer::Base.deliveries = []
    expect { @vacation.approved! }.to change{ ActionMailer::Base.deliveries.count }.by(1)
  end

  it "should not email user when already approved" do
    ActionMailer::Base.deliveries = []
    @vacation.approved!
    expect { @vacation.approved! }.to change{ ActionMailer::Base.deliveries.count }.by(0)   
  end

  it "should email user when request denied" do
    ActionMailer::Base.deliveries = []
    expect { @vacation.destroy }.to change{ ActionMailer::Base.deliveries.count }.by(1)
  end

end
