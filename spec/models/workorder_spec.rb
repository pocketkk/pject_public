require 'spec_helper'

    describe Workorder do
      let (:user) {FactoryGirl.create(:user) }
      before { @workorder = user.workorders.build(customer: "Best Restaurant Ever") }

  subject { @workorder }
  it { should respond_to (:customer) }
  it { should respond_to (:user_id) }

  describe "accessible attributes" do
      it "should not allow access to user_id" do
        expect do
          Workorder.new(user_id: user.id)
        end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end    
    end
    describe "when user_id is not present" do
       before { @workorder.user_id = nil }
       it { should_not be_valid }
     end
  end
  