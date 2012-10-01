require File.dirname(__FILE__) + '/../spec_helper'

describe Part do
  it "should be valid" do
    Part.new.should be_valid
  end
end
