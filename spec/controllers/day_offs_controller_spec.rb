require File.dirname(__FILE__) + '/../spec_helper'

describe DayOffsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => DayOff.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    DayOff.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    DayOff.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(day_off_url(assigns[:day_off]))
  end

  it "edit action should render edit template" do
    get :edit, :id => DayOff.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    DayOff.any_instance.stubs(:valid?).returns(false)
    put :update, :id => DayOff.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    DayOff.any_instance.stubs(:valid?).returns(true)
    put :update, :id => DayOff.first
    response.should redirect_to(day_off_url(assigns[:day_off]))
  end

  it "destroy action should destroy model and redirect to index action" do
    day_off = DayOff.first
    delete :destroy, :id => day_off
    response.should redirect_to(day_offs_url)
    DayOff.exists?(day_off.id).should be_false
  end
end
