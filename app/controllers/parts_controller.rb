class PartsController < ApplicationController
  def index
    @parts = Part.parts_current_branch(current_user.current_branch).where("ordered=?", false).ascending
    @part = current_user.parts.build if signed_in?
  end

  def show
    @part = Part.find(params[:id])
  end

  def new
    @part = Part.new
  end

  def ordered
    @part = Part.find(params[:id])
    if @part.update_attributes(:ordered => true)
      @update=current_user.updates.new
      @update.feed_item=current_user.name << " ordered parts."
      @update.save
      flash[:success] = "Part Ordered!"
      redirect_to parts_path
    else
      render :action => 'edit'
    end
  end

  def create
    @part = current_user.parts.build(params[:part])
    if @part.save
      @update=Update.new
      @update.feed_item=current_user.name.titleize << " added " << @part.name.titleize << " to the parts list."
      @update.user_id=current_user.id
      @update.save
      respond_to do |format|
          format.html { redirect_to parts_url, :notice  => "Added Part." }
          format.mobile {redirect_to parts_url, :notice  => "Added Part." }
        end
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
      redirect_to root_path, :notice  => "Successfully updated part."
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
