require File.dirname(__FILE__) + '/../spec_helper'

describe Chemical do
  it "should be valid" do
    Chemical.new.should be_valid
  end
end
