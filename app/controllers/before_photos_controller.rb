class BeforePhotosController < ApplicationController
  def index
    @before_photos = BeforePhoto.all
  end

  def show
    @before_photo = BeforePhoto.find(params[:id])
  end

  def new
    @before_photo = BeforePhoto.new
  end

  def create
    @before_photo = BeforePhoto.new(params[:before_photo])
    if @before_photo.save
      redirect_to @before_photo, :notice => "Successfully created before photo."
    else
      render :action => 'new'
    end
  end

  def edit
    @before_photo = BeforePhoto.find(params[:id])
  end

  def update
    @before_photo = BeforePhoto.find(params[:id])
    if @before_photo.update_attributes(params[:before_photo])
      redirect_to @before_photo, :notice  => "Successfully updated before photo."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @before_photo = BeforePhoto.find(params[:id])
    @before_photo.destroy
    redirect_to before_photos_url, :notice => "Successfully destroyed before photo."
  end
end
