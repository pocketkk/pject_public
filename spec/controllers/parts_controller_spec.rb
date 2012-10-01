require File.dirname(__FILE__) + '/../spec_helper'

describe PartsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Part.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Part.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Part.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(part_url(assigns[:part]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Part.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Part.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Part.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Part.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Part.first
    response.should redirect_to(part_url(assigns[:part]))
  end

  it "destroy action should destroy model and redirect to index action" do
    part = Part.first
    delete :destroy, :id => part
    response.should redirect_to(parts_url)
    Part.exists?(part.id).should be_false
  end
end
