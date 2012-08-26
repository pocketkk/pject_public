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
  end
  def show
    @workorder=Workorder.find(params[:id])
  end

end