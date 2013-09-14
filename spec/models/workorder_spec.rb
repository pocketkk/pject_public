require 'spec_helper'

describe Workorder do

    before :each do
        @user = FactoryGirl.build(:user)
    end

    it "has a valid factory" do
        expect(FactoryGirl.build(:workorder)).to be_valid
    end

    it "it is invalid without customer" do
        workorder = FactoryGirl.build(:workorder, customer: nil)
        expect(workorder).to have(1).error_on(:customer)
    end

    it "it is invalid without user" do
        workorder = FactoryGirl.build(:workorder, user_id: nil)
        expect(workorder).to have(1).error_on(:user_id)
    end

    it "it is invalid without street" do
        workorder = FactoryGirl.build(:workorder, street: nil)
        expect(workorder).to have(1).error_on(:street)
    end

    it "it is invalid without city" do
        workorder = FactoryGirl.build(:workorder, city: nil)
        expect(workorder).to have(1).error_on(:city)
    end

    it "it is invalid without state" do
        workorder = FactoryGirl.build(:workorder, state: nil)
        expect(workorder).to have(1).error_on(:state)
    end

    it "it is invalid without contact" do
        workorder = FactoryGirl.build(:workorder, contact: nil)
        expect(workorder).to have(1).error_on(:contact)
    end

    it "it is invalid without phonenumber" do
        workorder = FactoryGirl.build(:workorder, phonenumber: nil)
        expect(workorder).to have(1).error_on(:phonenumber)
    end

    it "it is invalid without duration" do
        workorder = FactoryGirl.build(:workorder, wo_duration: nil)
        expect(workorder).to have(1).error_on(:wo_duration)
    end

    it "is invalid when misc_notes exceed 200 characters" do
        workorder = FactoryGirl.build(:miscnotes_workorder)
        expect(workorder).to have(1).error_on(:misc_notes)
    end

    it "chronic converts chronic_wo_date to proper wo_date" do
        workorder = FactoryGirl.build(:duetoday_workorder)
        expect(workorder.wo_date.strftime("%m%d%Y")).to eq(Date.today.strftime("%m%d%Y"))
    end

    it "should remove extra characters from phonenumber before save" do
        workorder = FactoryGirl.build(:workorder, raw_phonenumber: "925-452-7857")
        expect(workorder.phonenumber).to eq(9254527857)
    end

    it "should format address in a readable way for google maps" do
        workorder = FactoryGirl.build(:workorder)
        expect(workorder.gmaps4rails_address).to eq("1234 Address, Oakland, CA")
    end

    it "should strip spaces from google maps link" do
        workorder = FactoryGirl.build(:workorder)
        expect(workorder.googlemaps_link).to eq("http://maps.apple.com/maps?q=#{workorder.gmaps4rails_address.gsub(" ", "%20")}")
    end

    it "can have assets attached to it" do
        workorder = FactoryGirl.create(:workorder)
        asset = FactoryGirl.create(:asset, workorder: workorder)
        asset2 = FactoryGirl.create(:asset, workorder: workorder)
        expect(workorder.assets.count).to eq(2)
    end

    it "can have before-photos attached to it" do
        workorder = FactoryGirl.create(:workorder)
        before_photo = FactoryGirl.create(:before_photo, workorder: workorder)
        expect(workorder.before_photos.count).to eq(1)
    end

    it "can have after-photos attached to it" do
        workorder = FactoryGirl.create(:workorder)
        after_photo = FactoryGirl.create(:after_photo, workorder: workorder)
        expect(workorder.after_photos.count).to eq(1)
    end

    # it "should reply with changes prior to save" do
    #     workorder = FactoryGirl.create(:workorder)
    #     workorder.save
    #     updated_workorder = Workorder.find(workorder.id)
    #     updated_workorder.customer = "Changed Name"
    #     updated_workorder.changes[:customer].should == ["Changed Name", workorder.customer]
    # end

    # it "should create update for changed workorders" do
    #     workorder = FactoryGirl.create(:workorder)
    #     workorder.save
    #     updated_workorder = Workorder.find(workorder.id)
    #     updated_workorder.customer = "Changed Name"
    #     message = updated_workorder.changes_message.first
    #     updated_workorder.save
    #     Update.last.feed_item.should == message
    # end

    # it "should create update for deleted workorders" do
    #     workorder = FactoryGirl.create(:workorder)
    #     workorder.save
    #     workorder.destroy
    #     Update.last.feed_item.should == workorder.destroy_message
    # end

    # it "should create an update for completed workorders" do
    #     workorder=FactoryGirl.create(:workorder)
    #     workorder.save
    #     workorder.complete!
    #     Update.last.feed_item.should == workorder.complete_message
    # end

    # it "workorder updates with changes to phone number should be formatted" do
    #     workorder=FactoryGirl.create(:workorder)
    #     workorder.save
    #     workorder.phonenumber = 9254527867
    #     message = workorder.changes_message.first
    #     workorder.save
    #     Update.last.feed_item.should == message
    # end

    # it "workorder updates with changes to assigned_to should be formatted" do
    #     workorder=FactoryGirl.create(:workorder)
    #     workorder.save
    #     workorder.assigned_to = 1
    #     message = workorder.changes_message.first
    #     workorder.save
    #     Update.last.feed_item.should == message
    # end

    # it "workorder updates with changes to date/time should be formatted" do
    #     workorder=FactoryGirl.create(:workorder)
    #     workorder.save
    #     workorder.wo_date = Time.zone.now + 1.days
    #     message = workorder.changes_message.first
    #     workorder.save
    #     Update.last.feed_item.should == message
    # end

    # it "workorder with multiple updates should include all changes formatted" do
    #     workorder=FactoryGirl.create(:workorder)
    #     workorder.save
    #     workorder.wo_date = Time.zone.now + 1.days
    #     workorder.contact = "The bomb"
    #     first_message = workorder.changes_message.first
    #     last_message = workorder.changes_message.last
    #     workorder.save
    #     Update.last.feed_item.should == last_message
    # end


end
