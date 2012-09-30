class WorkordersController < ApplicationController
  before_filter :signed_in_user
  
  def index
    @search=Workorder.search(params[:q])
    @workorders = params[:distinct].to_i.zero? ? @search.result : @search.result(distinct: true)
   
  end
  
  def calendar
    @workorders=Workorder.wo_current_branch(current_user.current_branch).wo_not_completed.ascending
    
    ### workorder lookup for calendar    
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
        #redirect_to :back
        render :action => 'new'
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
    @asset_status_options = {  "" => "",
                               "New - Ordered"    => "0" ,
                               "New - On Site"    => "10" ,
                               "New - Tested"     => "99" ,
                               "Used - Ordered"   => "1"  ,
                               "Used - On Site"   => "11" ,
                               "Used - Torn Down" => "25" ,
                               "Used - Rebuilt"   => "76" ,
                               "Used - Tested"    => "100"}
  end
  def new
    @workorder=Workorder.new
    @asset_status_options = {  "" => "",
                               "New - Ordered"    => "0" ,
                               "New - On Site"    => "10" ,
                               "New - Tested"     => "99" ,
                               "Used - Ordered"   => "1"  ,
                               "Used - On Site"   => "11" ,
                               "Used - Torn Down" => "25" ,
                               "Used - Rebuilt"   => "76" ,
                               "Used - Tested"    => "100"}
  end
  def complete
    @workorder = Workorder.find(params[:id])
    if @workorder.update_attributes(:completed => true)
      redirect_to root_path, :notice => "Workorder Completed!"
      @update=Update.new
      @update.feed_item="The workorder for " << @workorder.customer.titleize << " has been completed."
      @update.user_id=current_user.id
      @update.save
    else 
      redirect_to root_path, :error => "Workorder status not updated."
    end
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