class WorkordersController < ApplicationController
  before_filter :signed_in_user
  
  def index
    @old_workorders=Workorder.all(:order => 'wo_date ASC')
    @workorders=current_user.workorders.all(:order => 'wo_date ASC')
    @workorders_by_date=@workorders.group_by{|i| i.wo_date.to_date}
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
  
  def create
      @workorder = current_user.workorders.build(params[:workorder])
      if @workorder.save
        @update=Update.new
        @update.feed_item=current_user.name << " created a new workorder for " << @workorder.customer.titleize << "."
        @update.save
        flash[:success] = "Workorder created!"
        redirect_to root_url
      else
        flash[:error] = 'All fields must be filled to create a new workorder'
        redirect_to root_url
      end
    end
  
  def destroy
    @workorder=Workorder.find(params[:id])
    @update=Update.new
    @update.feed_item=current_user.name << " deleted the workorder for " << @workorder.customer.titleize << "."
    @workorder.destroy
    @update.save
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
      redirect_to root_url, :notice  => "Successfully updated workorder."
      @update=Update.new
      @update.feed_item=current_user.name << " updated the workorder for " << @workorder.customer.titleize << "."
      @update.save
    else
      render :action => 'edit'
    end
  end

end