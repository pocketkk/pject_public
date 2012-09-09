class WorkordersController < ApplicationController
  before_filter :signed_in_user
  
  def index
  end
  
  def create
      @machine = current_user.workorders.machines.build(params[:machine])
      if @machine.save
        flash[:success] = "Machine added to workorder!"
        redirect_to root_url
      else
        flash[:error] = 'Error unableto add machine to workorder'
        redirect_to root_url
      end
    end
  
  def destroy
  end
  def show
    @workorder=Workorder.find(params[:id])
  end

end