class WorkordersController < ApplicationController
  before_filter :signed_in_user
  
  def index
    @old_workorders=Workorder.all(:order => 'wo_date ASC')
    @workorders=Workorder.wo_current_branch(current_user.current_branch).ascending
  # workorder lookup for calendar    
    @workorders_by_date=@workorders.group_by{|i| i.wo_date.to_date}
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
    
  def create
      @workorder = current_user.workorders.build(params[:workorder])
      if @workorder.save
        @update=Update.new
        @update.feed_item=current_user.name << " created a new workorder for " << @workorder.customer.titleize << "."
        @update.user_id=current_user.id
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
    @update.user_id=current_user.id
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
    @asset_status_options = { "New - Ordered"    => "0" ,
                               "New - On Site"    => "10" ,
                               "New - Tested"     => "99" ,
                               "Used - Ordered"   => "1"  ,
                               "Used - On Site"   => "11" ,
                               "Used - Torn Down" => "25" ,
                               "Used - Rebuilt"   => "76" ,
                               "Used - Tested"    => "100"}
  end
  def update
    @workorder= Workorder.find(params[:id])
    if @workorder.update_attributes(params[:workorder])
      redirect_to root_url, :notice  => "Successfully updated workorder."
      @update=Update.new
      @update.feed_item=current_user.name << " updated the workorder for " << @workorder.customer.titleize << "."
      @update.user_id=current_user.id
      @update.save
    else
      render :action => 'edit'
    end
  end

end