require 'spec_helper'

describe "Sms" do

  it "should be valid" do
    client = Sms.new
    client.should be_valid
  end

  context "#send" do
    
    it "should send an sms" do
      client = Sms.new
      expect { client.send(123456789, "Message") }.to change{ Sms.sent_smses.count }.by(1)
    end

  end

end


