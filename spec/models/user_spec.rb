require 'spec_helper'

describe User do

    it "has a valid factory" do
        expect(FactoryGirl.build(:user)).to be_valid
    end

    it "is valid with a name" do
        user = FactoryGirl.build(:user)
        expect(user).to be_valid
    end

    it "is invalid without a name" do
        user = FactoryGirl.build(:user, name: nil)
        expect(user).to have(1).error_on(:name)
    end

    it "is invalid without an email address" do
        user = FactoryGirl.build(:user, email: nil)
        expect(user).to have(2).error_on(:email)
    end

    it "is invalid without valid email address" do
        user = FactoryGirl.build(:user, email: "test.com")
        expect(user).to have(1).error_on(:email)
    end

    it "is valid with a password and matching password confirmation" do
        user = FactoryGirl.build(:user)
        expect(user).to be_valid
    end

    it "is invalid without matching passwords" do
        user = FactoryGirl.build(:user, password_confirmation: "blahblah")
        expect(user).to have(1).error_on(:password)
    end

    it "is invalid without a password of a appropriate length" do
        user = FactoryGirl.build(:user, password: "blah",
         password_confirmation: "blah")
        expect(user).to have(1).error_on(:password)
    end

    it "is invalid without a current_branch" do
        user = FactoryGirl.build(:user, current_branch: nil)
        expect(user).to have(1).error_on(:current_branch)
    end

    it "is invalid without a role" do
        user = FactoryGirl.build(:user, role: nil)
        expect(user).to have(1).error_on(:role)
    end

    it "is valid with a phonenumber with invalid characters" do
        user = FactoryGirl.build(:user, raw_phonenumber: "925-111-5555")
        expect(user).to be_valid
    end

    it "has username saved with spaces stripped" do
        user = FactoryGirl.create(:user, name: " Jason Crump ")
        expect(user.name).to eq "Jason Crump"
    end

    it "has email address changed to lower case before save" do
        user = FactoryGirl.create(:user, email: "CRump@test.com")
        expect(user.email).to eq "crump@test.com"
    end

    it "is invalid without a unique email address" do
        user = FactoryGirl.create(:user, email: "test@test.com")
        user2 = FactoryGirl.build(:user, email: "test@test.com")
        expect(user2).to have(1).error_on(:email)
    end

    it "is able to build a workorder" do
        user=FactoryGirl.create(:user)
        workorder=user.workorders.build(customer: "Restaurant Name",
                                        street: "1234 Address",
                                        city: "Oakland",
                                        state: "CA",
                                        phonenumber: "9254527867",
                                        contact: "James",
                                        misc_notes: "Park in the back",
                                        branch: "350",
                                        wo_type: "New Install",
                                        wo_duration: 1)
        expect(workorder).to be_valid
    end

end
