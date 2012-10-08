class StaticPagesController < ApplicationController
  def home
     @workorder = current_user.workorders.build if signed_in?
     @workorders=Workorder.wo_current_branch(current_user.current_branch).wo_not_completed.ascending.paginate(page: params[:page], :per_page => 5) if signed_in?
     @completed_workorders=Workorder.wo_current_branch(current_user.current_branch).wo_completed.descending.paginate(page: params[:page], :per_page => 3) if signed_in?
     @updates = Update.all(:order => 'created_at DESC', :limit => "15") 
     @assets_need_to_order = Asset.joins(:workorder).where("workorders.branch=?",current_user.current_branch).where('workorders.completed=?',false).where('status=?','0')
     @parts = Part.all
   end

   def rebuilder_view
     @all_workorders=Workorder.wo_current_branch(current_user.current_branch).wo_not_completed.ascending
     @workorders=Workorder.wo_current_branch(current_user.current_branch).wo_not_completed.ascending.paginate(page: params[:page])
     @completed_workorders=Workorder.wo_current_branch(current_user.current_branch).wo_completed.descending.paginate(page: params[:page]) if signed_in?
     @updates = Update.all(:order => 'created_at DESC', :limit => "25")
     @assets = Asset.joins(:workorder).where('workorders.branch=?', current_user.current_branch).where('workorders.completed=?',false).order('workorders.wo_date ASC')
     @assets_without_serials = Asset.joins(:workorder).where("workorders.branch=?",current_user.current_branch).where('workorders.completed=?',false).serial_blank.order('workorders.wo_date ASC')
  end 

  def help
  end
  
  def about
  end
  
  def contact
  end
end
