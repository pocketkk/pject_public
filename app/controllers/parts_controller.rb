class PartsController < ApplicationController
  def index
    @parts = Part.parts_current_branch(current_user.current_branch).ascending
    @part = current_user.parts.build if signed_in?
  end

  def show
    @part = Part.find(params[:id])
  end

  def new
    @part = Part.new
  end

  def create
    @part = current_user.parts.build(params[:part])
    if @part.save
      @update=Update.new
      @update.feed_item=current_user.name.titleize << " added " << @part.name.titleize << " to the parts list."
      @update.user_id=current_user.id
      @update.save
      flash[:success] = "Added to Parts List!"
      redirect_to parts_path
    else
      render :action => 'new'
    end
  end

  def edit
    @part = Part.find(params[:id])
  end

  def update
    @part = Part.find(params[:id])
    if @part.update_attributes(params[:part])
      redirect_to @part, :notice  => "Successfully updated part."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @part = Part.find(params[:id])
    @update=Update.new
    @update.feed_item=current_user.name.titleize << " removed " << @part.name.titleize << " from the parts list."
    @update.user_id=current_user.id
    @update.save
    @part.destroy
    redirect_to parts_url, :notice => "Successfully destroyed part."
  end
end
