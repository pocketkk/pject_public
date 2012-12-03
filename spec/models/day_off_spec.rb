require File.dirname(__FILE__) + '/../spec_helper'

describe DayOff do
  it "should be valid" do
    DayOff.new.should be_valid
  end
end
