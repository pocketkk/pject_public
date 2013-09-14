require 'spec_helper'

describe DocumentsController do

render_views

    before(:each) do
        @user=FactoryGirl.create(:user)
        test_sign_in @user
    end

    describe "POST create" do
        it "should create a new update" do
            expect {
                post :create, document: Factory.attributes_for(:document)
            }.to change(Update, :count).by(1)
        end
    end

end
