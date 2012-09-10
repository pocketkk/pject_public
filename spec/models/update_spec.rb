require File.dirname(__FILE__) + '/../spec_helper'

describe Update do
  it "should be valid" do
    Update.new.should be_valid
  end
end
