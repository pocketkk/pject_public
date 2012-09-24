require File.dirname(__FILE__) + '/../spec_helper'

describe AfterPhoto do
  it "should be valid" do
    AfterPhoto.new.should be_valid
  end
end
