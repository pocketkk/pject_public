require 'spec_helper'

describe WorkordersController do

    render_views

    before(:each) do
      @user=FactoryGirl.create(:user)
      test_sign_in @user
    end

    describe "GET index" do

        it "gets all searched workorders" do
            workorder=FactoryGirl.build(:workorder)
            workorder.customer="Test"
            workorder.save
            workorders=Workorder.where("customer=Test")
            get :index, :q => {customer_cont: "Test"}
            @workorders == workorders
        end

    end

    describe "complete#workorder" do
      it "should complete workorder when visited" do
        workorder=Factory.create(:workorder)
        expect { visit "/workorders/#{workorder.id}/complete" }.
          to change{ Sms.sent_smses.count }.by(2)
      end
    end

    describe "POST create" do

        it "should create a workorder when supplied with valid info" do
            expect {
            post :create, workorder: FactoryGirl.attributes_for(:workorder)
            }.to change(Workorder, :count).by(1)
        end

        it "should redirect to root path" do
            post :create, workorder: FactoryGirl.attributes_for(:workorder)
            response.should redirect_to(root_path)
        end

        it "should not create workorder when supplied with invalid info" do
            expect {
                post :create, workorder: FactoryGirl.attributes_for(:workorder,
                    :customer => nil)
                }.to_not change(Workorder, :count)
        end

        it "should render new page when incomplete workorder" do
            post :create, workorder: Factory.attributes_for(:workorder,
                customer: nil)
            response.should render_template('workorders/new')
        end

        it "should flash error when incomplete workorder" do
            post :create, workorder: Factory.attributes_for(:workorder,
                customer: nil)
            flash[:error].should =~ /All fields/i
        end

        it "should create a new update" do
            expect {
                post :create, workorder: Factory.attributes_for(:workorder)
                }.to change(Update, :count)
        end

    end

    describe "PUT update" do

        before(:each) do
            @workorder=Factory.create(:workorder)
        end

        it "should update a workorder when supplied with valid info" do
            expect {
            put :update, id: @workorder, workorder: FactoryGirl.attributes_for(:workorder)
            }.to change(Workorder, :count).by(0)
        end

        it "should redirect to root path" do
            put :update, id: @workorder, workorder: FactoryGirl.attributes_for(:workorder)
            response.should redirect_to(root_path)
        end

        it "should render edit page when incomplete workorder" do
            put :update, id: @workorder, workorder: Factory.attributes_for(:workorder,
                customer: nil)
            response.should render_template('workorders/edit')
        end

        it "should create a new update" do
            expect {
                put :update, id: @workorder,
                workorder: Factory.attributes_for(:workorder, customer: "Beyonce")
                }.to change(Update, :count)
        end

        it "should create multiple updates for multiple changes" do
            expect {
                put :update, id: @workorder,
                workorder: Factory.attributes_for(:workorder,
                    :customer => "Bobby", :phonenumber => 9254527867)
                }.to change(Update, :count).by(2)
        end

        it "should create update for completed workorder" do
            expect {
                put :complete, id: @workorder,
                    workorder: Factory.attributes_for(:workorder)
                }.to change(Update, :count).by(1)
        end

        it "should create update for workorder updated on calendar" do
            expect {
                put :complete, id: @workorder,
                    workorder: Factory.attributes_for(:workorder, date: (Time.zone.now + 1.day))
                }.to change(Update, :count).by(1)
        end

    end

end
