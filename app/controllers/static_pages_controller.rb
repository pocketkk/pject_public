class StaticPagesController < ApplicationController
  def home
     @workorder = current_user.workorders.build if signed_in?
     @workorders=Workorder.wo_current_branch(current_user.current_branch).wo_not_completed.ascending.paginate(page: params[:page]) if signed_in?
     @completed_workorders=Workorder.wo_current_branch(current_user.current_branch).wo_completed.ascending.paginate(page: params[:page]) if signed_in?
     @old_workorders = current_user.workorders.paginate(page: params[:page], :order => 'wo_date ASC') if signed_in?
     @updates = Update.all(:order => 'created_at DESC', :limit => "15")
   end

   def rebuilder_view
     @all_workorders=Workorder.wo_current_branch(current_user.current_branch).wo_not_completed.ascending
     @workorders=Workorder.wo_current_branch(current_user.current_branch).wo_not_completed.ascending.paginate(page: params[:page])
     @completed_workorders=Workorder.wo_current_branch(current_user.current_branch).wo_completed.ascending.paginate(page: params[:page]) if signed_in?
     @updates = Update.all(:order => 'created_at DESC')
     @assets = Asset.joins(:workorder).where('workorders.branch=350').order('workorders.wo_date ASC')
     @assets_without_serials = Asset.joins(:workorder).where("workorders.branch=?",current_user.current_branch).needs_serial.order('workorders.wo_date ASC')
  end 

  def help
  end
  
  def about
  end
  
  def contact
  end
end
