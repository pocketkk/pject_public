require 'spec_helper'

describe TasksController do

    render_views

    before(:each) do
        @user=FactoryGirl.create(:user)
        test_sign_in @user
    end

    describe "POST create" do
        it "emails followers and assigned to users" do
            @user1=Factory.create(:user)
            @user2=Factory.create(:user)
            @user3=Factory.create(:user)
            ActionMailer::Base.deliveries = []
            expect {
                post :create,
                task: Factory.attributes_for(:task, followers_for: [@user1.id,
                 @user2.id])
                }.to change(ActionMailer::Base.deliveries, :count).by(2)
        end
        it "emails assigned to users" do
            @user1=Factory.create(:user)
            @user2=Factory.create(:user)
            ActionMailer::Base.deliveries = []
            expect {
                post :create,
                task: {content: "Test", branch: 350, assigned_to: @user2.id}
                }.to change(ActionMailer::Base.deliveries, :count).by(1)
        end
    end
    describe "PUT update" do
        it "emails followers and owner on completion" do
            @user1=Factory.create(:user)
            @user2=Factory.create(:user)
            @user3=Factory.create(:user)
            @task=Factory.create(:task, followers_for: [@user2.id],
                 assigned_to: @user3.id)
            ActionMailer::Base.deliveries = []
            expect {
                put :update, id: @task.id,
                task: Factory.attributes_for(:task, completed: true)
                }.to change(ActionMailer::Base.deliveries, :count).by(3)
        end
    end

end
