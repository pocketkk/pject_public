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
        render 'static_pages/home'
      end
    end
  
  def destroy
  end
end