require File.dirname(__FILE__) + '/../spec_helper'

describe BeforePhoto do
  it "should be valid" do
    BeforePhoto.new.should be_valid
  end
end
