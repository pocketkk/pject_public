require File.dirname(__FILE__) + '/../spec_helper'

describe Bug do
  it "should be valid" do
    Bug.new.should be_valid
  end
end
