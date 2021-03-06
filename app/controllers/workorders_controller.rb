class WorkordersController < ApplicationController
  before_filter :signed_in_user, :except => :calendar_feed

  def index
    @search=Workorder.search(params[:q])
    @workorders = params[:distinct].to_i.zero? ? @search.result.paginate(page: params[:page], :per_page => 6) : @search.result(distinct: true).paginate(page: params[:page], :per_page => 6)
  end

  def calendar
    ### Mobile Requests ###
    @workorders_mobile=Workorder.wo_current_branch(current_user.current_branch).where('wo_date IS NOT NULL').ascending
    @workorders=Workorder.wo_current_branch(current_user.current_branch).where('wo_date IS NOT NULL').ascending
    @workorders_without_dates=Workorder.wo_current_branch(current_user.current_branch).wo_no_date.wo_not_completed.ascending if signed_in?

    ### workorder lookup for calendar
    @workorders_by_date=@workorders.group_by{|i| i.wo_date.to_date}
    @users=user_roster
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @tasks = Task.tasks_current_user(current_user)
  end

  def calendar_feed
    @workorders=Workorder.wo_current_branch(params[:id]).where('wo_date IS NOT NULL').ascending
    @workorders_by_date=@workorders.group_by{|i| i.wo_date.to_date}
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    respond_to do |format|
        format.ics
      end
  end

  def create
    @workorder = current_user.workorders.build(params[:workorder])
    if @workorder.save
      Updater.new(@workorder, update_type: :new)
      respond_to do |format|
        format.html { redirect_to root_url, :notice  => "Successfully created workorder." }
        format.mobile {redirect_to root_url, :notice  => "Created workorder." }
        format.js
      end
    else
      flash[:error] = 'All fields must be filled to create a new workorder'
      @users = user_roster
      render :action => 'new'
    end
  end

  def destroy
    @workorder=Workorder.find(params[:id])
    @workorder.destroy
    flash[:success] = "Workorder Deleted"
    redirect_to root_path
  end

  def show
    @workorder=Workorder.find(params[:id], :include => [:assets, :followers])
    @followup_workorder=Workorder.new
    @json=@workorder.to_gmaps4rails
    @assets_need_to_order = Asset.includes(:workorder).where("workorders.branch=?",current_user.current_branch).where('workorders.completed=?',false).where('status=?','0')
    @users = user_roster
    @workorder.assigned_to ? @installer=User.find(@workorder.assigned_to) : @no_one_assigned="No one assigned"
    @commentable = @workorder
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def edit
    @workorder=Workorder.find(params[:id])
    @workorder_comparison=Workorder.find(params[:id])
    @users = user_roster
    @workorder.assigned_to ? @installer=User.find(@workorder.assigned_to) : @no_one_assigned="No one assigned"
  end

  def new
    @workorder=Workorder.new
    @users = user_roster
  end

  def toggle_follower
    @workorder=Workorder.find(params[:id])
    @workorder.toggle_follower(current_user)
    redirect_to @workorder, notice: "Changed following status"
  end

  def complete
    @workorder = Workorder.find(params[:id])
    if @workorder.complete!
      Updater.new(@workorder, update_type: :update, user: current_user, message: @workorder.complete_message(current_user))
      @workorder.followers.each do |follower|
        user=follower.user
        if user.receive_mails == true
          PdfMailer.mail_workorder(@workorder,user,"Completed").deliver
        end
        if user.texts == true
          unless user.phone_number.blank?
            Sms.new.send_sms(phone_number: @workorder.user.phone_number,
                             message: @workorder.complete_message(current_user))
          end
        end
      end
      redirect_to root_path, :notice => "Workorder Completed!"
    else
      redirect_to root_path, :error => "Workorder status not updated."
    end
  end

  def update_on_calendar
    @workorder= Workorder.find(params[:id])
    @original_workorder = Workorder.find(params[:id])
    @workorder_comparison=Workorder.find(params[:id])
    if @workorder.update_attributes(params[:workorder])
      @workorder.update_update(current_user, @original_workorder)
      respond_to do |format|
        format.html { redirect_to calendar_url,
          :notice  => "Successfully updated workorder." }
        format.js
      end
    else
      render :action => 'edit'
    end
  end

  def update
    @workorder= Workorder.find(params[:id])
    @original_workorder = Workorder.find(params[:id])
    if @workorder.update_attributes(params[:workorder])
      @workorder.update_update(current_user, @original_workorder)
      respond_to do |format|
        format.html { redirect_to root_url,
          :notice  => "Successfully updated workorder." }
        format.mobile {redirect_to root_url,
          :notice  => "Updated workorder." }
        format.js
      end
    else
      @users = user_roster
      render :action => 'edit'
    end
  end
  
  def past_due
    @workorders=Workorder.wo_current_branch(current_user.current_branch).
         wo_not_completed.where('wo_date between ? and ?', Date.today-100.years, Date.today-1).
         ascending.paginate(page: params[:page], :per_page => 5) if signed_in?
  end

  def unassigned
    @assets_without_serials = Asset.serial_nil.serial_blank
  end
  def need_to_order
    @assets_need_to_order = Asset.where(status: "need_to_order")
  end
  def timeoff
    @users=User.where(current_branch: current_user.current_branch)
  end
end
