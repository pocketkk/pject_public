class StaticPagesController < ApplicationController
  def home
     @workorder = current_user.workorders.build if signed_in?
     @workorders=Workorder.wo_current_branch(current_user.current_branch).
        wo_not_completed.ascending.paginate(page: params[:page],
        :per_page => 5).includes(:user).includes(:assets) if signed_in?
     @completed_workorders=Workorder.wo_current_branch(current_user.
        current_branch).wo_recently_completed.includes(:user).includes(:assets) if signed_in?
     @updates = Update.all(:order => 'created_at DESC',
        :limit => "15", :include => :user) if signed_in?
     @users=user_roster if signed_in?
     @posts = Post.recently_added if signed_in?

     #Tasks
    session[:context] = "All" unless session[:context]
    if session[:context]=="All"
      @incomplete_tasks = Task.tasks_current_user(current_user).
        task_not_completed if signed_in?
    else
      @incomplete_tasks = Task.tasks_current_user(current_user).
        task_not_completed.task_context(session[:context]) if signed_in?
    end
    @taskable = current_user if signed_in?

    @completed_tasks = Task.tasks_current_user(current_user).
      task_completed.limit(5) if signed_in?
    @tasks=Task.for(current_user).includes(:taskable).includes(:followers).to_a
    #@tasks = @taskable.tasks if signed_in?
    @task = Task.new

     @workorders_pastdue = 0
    if @workorders
      @workorders.each do |workorder|
        unless workorder.wo_date.nil?
          @workorders_pastdue +=1 unless workorder.wo_date >= Date.today - 1.day
        end
      end
    end

     @user_days_off_unapproved_count = 0
     if @users
      @users.each do |user|
        user.day_offs.each do |day_off|
          if day_off.start_date >= Date.today || Date.today <= day_off.end_date
            @user_days_off_unapproved_count +=1 unless day_off.approved
          end
        end
      end
    end
     @assets_need_to_order = Asset.joins(:workorder).where("workorders.branch=?",current_user.current_branch).where('workorders.completed=?',false).where('status=?','0').includes(:workorder) if signed_in?
     @workorders_without_dates=Workorder.wo_current_branch(current_user.current_branch).wo_not_completed.wo_no_date.ascending if signed_in?
     @parts = Part.parts_current_branch(current_user.current_branch).where("ordered=?", false).order("name ASC") if signed_in?
     @assets_without_serials = Asset.joins(:workorder).where("workorders.branch=?",current_user.current_branch).where('workorders.completed=?',false).serial_blank.order('workorders.wo_date ASC').includes(:workorder) if signed_in?
   end

   def rebuilder_view
     @all_workorders=Workorder.wo_current_branch(current_user.current_branch).wo_not_completed.ascending
     @workorders=Workorder.wo_current_branch(current_user.current_branch).wo_not_completed.ascending.paginate(page: params[:page], :per_page => 5) if signed_in?
     @workorders_without_dates=Workorder.wo_current_branch(current_user.current_branch).wo_no_date.ascending if signed_in?
     @completed_workorders=Workorder.wo_current_branch(current_user.current_branch).wo_completed.descending.paginate(page: params[:page]) if signed_in?
     @updates = Update.all(:order => 'created_at DESC', :limit => "25", :include => :user)
     @assets = Asset.joins(:workorder).where('workorders.branch=?', current_user.current_branch).where('workorders.completed=?',false).order('workorders.wo_date ASC')
     @assets_without_serials = Asset.joins(:workorder).where("workorders.branch=?",current_user.current_branch).where('workorders.completed=?',false).serial_blank.order('workorders.wo_date ASC')
  end

  def help
  end

  def toggle_mobile
    session[:mobylette_override] = nil unless session[:mobylette_override] == nil
    redirect_to root_url, :notice  => "Toggled mobile view!"
  end

  def test_mobile
    session[:mobylette_override] = :force_mobile
    redirect_to root_url, :notice  => "Forced mobile view!"
  end

  def toggle_normal
    session[:mobylette_override] = :ignore_mobile unless session[:mobylette_override]==:ignore_mobile
    redirect_to root_url, :notice  => "Toggled mobile view!"
  end

  def about
  end

  def contact
  end

  def landing_page
    @workorders = Workorder.wo_recently_completed
  end

end
