require File.dirname(__FILE__) + '/../spec_helper'

describe UpdatesController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Update.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Update.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Update.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(update_url(assigns[:update]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Update.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Update.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Update.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Update.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Update.first
    response.should redirect_to(update_url(assigns[:update]))
  end

  it "destroy action should destroy model and redirect to index action" do
    update = Update.first
    delete :destroy, :id => update
    response.should redirect_to(updates_url)
    Update.exists?(update.id).should be_false
  end
end
