require File.dirname(__FILE__) + '/../spec_helper'

describe AfterPhotosController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => AfterPhoto.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    AfterPhoto.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    AfterPhoto.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(after_photo_url(assigns[:after_photo]))
  end

  it "edit action should render edit template" do
    get :edit, :id => AfterPhoto.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    AfterPhoto.any_instance.stubs(:valid?).returns(false)
    put :update, :id => AfterPhoto.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    AfterPhoto.any_instance.stubs(:valid?).returns(true)
    put :update, :id => AfterPhoto.first
    response.should redirect_to(after_photo_url(assigns[:after_photo]))
  end

  it "destroy action should destroy model and redirect to index action" do
    after_photo = AfterPhoto.first
    delete :destroy, :id => after_photo
    response.should redirect_to(after_photos_url)
    AfterPhoto.exists?(after_photo.id).should be_false
  end
end
