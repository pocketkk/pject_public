require 'spec_helper'

describe "Sms" do

  it "should be valid" do
    client = Sms.new
    client.should be_valid
  end

  context "#send_sms" do
    
    it "should send an sms" do
      client = Sms.new
      expect { client.send_sms(phone_number: 123456789, message: "Message") }.to change{ Sms.sent_smses.count }.by(1)
    
    end

    it "should accept a hash of params" do
      client = Sms.new
      expect { client.send_sms(phone_number: 9254527867, message: "Hi there") }.to change{ Sms.sent_smses.count }.by(1)
    end    

    it "should raise an error if no phone number present" do
      client = Sms.new
      expect { client.send_sms(not_phone: 123, message: "Hi there") }.to raise_error(SmsArgumentError)
    end
  end

end
