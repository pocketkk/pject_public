require File.dirname(__FILE__) + '/../spec_helper'

describe BeforePhotosController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => BeforePhoto.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    BeforePhoto.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    BeforePhoto.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(before_photo_url(assigns[:before_photo]))
  end

  it "edit action should render edit template" do
    get :edit, :id => BeforePhoto.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    BeforePhoto.any_instance.stubs(:valid?).returns(false)
    put :update, :id => BeforePhoto.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    BeforePhoto.any_instance.stubs(:valid?).returns(true)
    put :update, :id => BeforePhoto.first
    response.should redirect_to(before_photo_url(assigns[:before_photo]))
  end

  it "destroy action should destroy model and redirect to index action" do
    before_photo = BeforePhoto.first
    delete :destroy, :id => before_photo
    response.should redirect_to(before_photos_url)
    BeforePhoto.exists?(before_photo.id).should be_false
  end
end
