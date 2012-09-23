require File.dirname(__FILE__) + '/../spec_helper'

describe Assetnote do
  it "should be valid" do
    Assetnote.new.should be_valid
  end
end
