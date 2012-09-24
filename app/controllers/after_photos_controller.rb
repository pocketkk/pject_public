class AfterPhotosController < ApplicationController
  def index
    @after_photos = AfterPhoto.all
  end

  def show
    @after_photo = AfterPhoto.find(params[:id])
  end

  def new
    @after_photo = AfterPhoto.new
  end

  def create
    @after_photo = AfterPhoto.new(params[:after_photo])
    if @after_photo.save
      redirect_to @after_photo, :notice => "Successfully created after photo."
    else
      render :action => 'new'
    end
  end

  def edit
    @after_photo = AfterPhoto.find(params[:id])
  end

  def update
    @after_photo = AfterPhoto.find(params[:id])
    if @after_photo.update_attributes(params[:after_photo])
      redirect_to @after_photo, :notice  => "Successfully updated after photo."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @after_photo = AfterPhoto.find(params[:id])
    @after_photo.destroy
    redirect_to after_photos_url, :notice => "Successfully destroyed after photo."
  end
end
