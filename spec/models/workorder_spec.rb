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

    it "should add default followers" do
        manager= Factory.create(:user, role: "Branch Manager")
        sales = Factory.create(:user)
        installer = Factory.create(:user, role: "Installer")
        rebuilder = Factory.create(:user, role: "Rebuilder")
        workorder = Factory.create(:workorder)
        workorder.followers.count.should == 4
    end

    it "should email default followers on creation" do
        manager= Factory.create(:user, role: "Branch Manager", receive_mails: true)
        sales = Factory.create(:user, receive_mails: true)
        installer = Factory.create(:user, role: "Installer", receive_mails: true)
        rebuilder = Factory.create(:user, role: "Rebuilder", receive_mails: true)
        User.all.count.should == 4
        ActionMailer::Base.deliveries = []
        # count will be incremented by one due to welcome letter
        # for user created with workorder
        expect {
            workorder = Factory.create(:workorder)
        }.to change{ActionMailer::Base.deliveries.count}.by(5)
        Follower.count.should == 4
    end
    

end
