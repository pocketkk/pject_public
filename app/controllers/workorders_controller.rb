class WorkordersController < ApplicationController
  before_filter :signed_in_user
  
  def index
  end
  
  def create
      @workorder = current_user.workorders.build(params[:workorder])
      if @workorder.save
        flash[:success] = "Workorder created!"
        redirect_to root_url
      else
        flash[:error] = 'All fields must be filled to create a new workorder'
        redirect_to root_url
      end
    end
  
  def destroy
    Workorder.find(params[:id]).destroy
    flash[:success] = "Workorder Deleted"
    redirect_to root_path
  end
  def show
    @workorder=Workorder.find(params[:id])
  end
  def edit
    @workorder=Workorder.find(params[:id])
  end
  def update
    @workorder= Workorder.find(params[:id])
    if @workorder.update_attributes(params[:workorder])
      redirect_to @workorder, :notice  => "Successfully updated workorder."
    else
      render :action => 'edit'
    end
  end

end