class WorkordersController < ApplicationController
  before_filter :signed_in_user, :except => :calendar_feed

  def index
    @search=Workorder.search(params[:q])
    @workorders = params[:distinct].to_i.zero? ? @search.result.paginate(page: params[:page], :per_page => 6) : @search.result(distinct: true).paginate(page: params[:page], :per_page => 6)
  end

  def calendar
    @workorders=Workorder.wo_current_branch(current_user.current_branch).where('wo_date IS NOT NULL').ascending
    @workorders_without_dates=Workorder.wo_current_branch(current_user.current_branch).wo_no_date.wo_not_completed.ascending if signed_in?

    ### workorder lookup for calendar
    @workorders_by_date=@workorders.group_by{|i| i.wo_date.to_date}
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
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

        @update=current_user.updates.new
        @update.feed_item=current_user.name << " created a " << @workorder.wo_type.downcase <<  " workorder for " << @workorder.customer.titleize << "."
        @update.save

        @users_to_email_rebuilders=User.where('current_branch=?', current_user.current_branch).where('receive_mails=?', true).where('role=?', 'Rebuilder')
        @users_to_email_branch_manager=User.where('current_branch=?', current_user.current_branch).where('receive_mails=?', true).where('role=?', 'Branch Manager')
        @users_to_email_regional_manager=User.where('current_branch=?', current_user.current_branch).where('receive_mails=?', true).where('role=?', 'Regional Manager')
        @users_to_email=@users_to_email_rebuilders+@users_to_email_branch_manager+@users_to_email_regional_manager

        @users_rebuilders=User.where('current_branch=?', current_user.current_branch).where('texts=?', true).where('role=?','Rebuilder')
        @users_branchmanagers=User.where('current_branch=?', current_user.current_branch).where('texts=?', true).where('role=?','Branch Manager')
        @users_regionalmanagers=User.where('current_branch=?', current_user.current_branch).where('texts=?', true).where('role=?','Regional Manager')
        @users_to_text=@users_rebuilders + @users_branchmanagers + @users_regionalmanagers
        flash[:success] = "Workorder created!"

        @users_to_email.each do |user|
          PdfMailer.mail_workorder(@workorder,user,"New").deliver
        end

        @users_to_text.each do |user|
            client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
              unless user.phone_number.nil?
                 # Create and send an SMS message
                 client.account.sms.messages.create(
                   from: TWILIO_CONFIG['from'],
                   to: user.phone_number,
                   body: "A " << @workorder.wo_type.downcase << " workorder for " << @workorder.customer.titleize << " has been created! " << url_for(@workorder)
                 )
              end
        end

        redirect_to root_url
      else
        flash[:error] = 'All fields must be filled to create a new workorder'
        #redirect_to :back
        @users = User.where("current_branch=?",current_user.current_branch)
        render :action => 'new'
      end
    end

  def destroy
    @workorder=Workorder.find(params[:id])

    @update=current_user.updates.new
    @update.feed_item=current_user.name << " deleted the workorder for " << @workorder.customer.titleize << "."

    @workorder.destroy
    @update.save
    flash[:success] = "Workorder Deleted"
    redirect_to root_path
  end

  def show
    @workorder=Workorder.find(params[:id])
    @followup_workorder=Workorder.new
    @json=@workorder.to_gmaps4rails
    @assets_need_to_order = Asset.joins(:workorder).where("workorders.branch=?",current_user.current_branch).where('workorders.completed=?',false).where('status=?','0')
    @users = User.where("current_branch=?",current_user.current_branch)
    @workorder.assigned_to ? @installer=User.find(@workorder.assigned_to) : @no_one_assigned="No one assigned"

    @commentable = @workorder
    @comments = @commentable.comments
    @comment = Comment.new

  end

  def edit
    @workorder=Workorder.find(params[:id])
    @workorder_comparison=Workorder.find(params[:id])
    @users = User.where("current_branch=?",current_user.current_branch)

    @workorder.assigned_to ? @installer=User.find(@workorder.assigned_to) : @no_one_assigned="No one assigned"

  end

  def new
    @workorder=Workorder.new
    @users = User.where("current_branch=?",current_user.current_branch)
  end

  def complete
    @workorder = Workorder.find(params[:id])
    if @workorder.update_attributes(:completed => true)
      redirect_to root_path, :notice => "Workorder Completed!"
      @update=Update.new
      @update.feed_item="The workorder for " << @workorder.customer.titleize << " has been completed."
      @update.user_id=current_user.id
      @update.save

      @users_branchmanagers=User.where('current_branch=?', current_user.current_branch).where('texts=?', true).where('role=?','Branch Manager')
      @users_regionalmanagers=User.where('current_branch=?', current_user.current_branch).where('texts=?', true).where('role=?','Regional Manager')

      @users_to_email_branch_manager=User.where('current_branch=?', current_user.current_branch).where('receive_mails=?', true).where('role=?', 'Branch Manager')
      @users_to_email_regional_manager=User.where('current_branch=?', current_user.current_branch).where('receive_mails=?', true).where('role=?', 'Regional Manager')
      @users_to_email=@users_to_email_branch_manager+@users_to_email_regional_manager

      if @workorder.user.receive_mails == true
        PdfMailer.mail_workorder(@workorder,@workorder.user,"Completed").deliver
      end

      @users_to_email.each do |user|
        PdfMailer.mail_workorder(@workorder,user,"Completed").deliver
      end


      if @workorder.user.texts == true
        client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])

             # Create and send an SMS message
             client.account.sms.messages.create(
               from: TWILIO_CONFIG['from'],
               to: @workorder.user.phone_number,
               body: @workorder.customer.titleize << "'s workorder has been completed! " << url_for(@workorder)
             )
      end

      @users_to_text=@users_branchmanagers + @users_regionalmanagers

      @users_to_text.each do |user|
          unless user==@workorder.user
              client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])

                   # Create and send an SMS message
                   client.account.sms.messages.create(
                     from: TWILIO_CONFIG['from'],
                     to: user.phone_number,
                     body: @workorder.customer.titleize << "'s " << @workorder.wo_type.downcase << " workorder has been completed! "  << url_for(@workorder)
                   )
          end
      end

    else
      redirect_to root_path, :error => "Workorder status not updated."
    end
  end

  def update_on_calendar
     @workorder= Workorder.find(params[:id])
      @workorder_comparison=Workorder.find(params[:id])
      if @workorder.update_attributes(params[:workorder])
        @workorder_changes=@workorder.differs_from @workorder_comparison,
                :ignore_attributes=>['id', 'created_at', 'updated_at', 'latitude','longitude','gmaps']
        @workorder_changes.each do |key, value|
          @update=current_user.updates.new
          @update.feed_item=current_user.name << " changed " << @workorder.customer.titleize << " from #{value.last} to #{value.first}."
          @update.save
        end
        respond_to do |format|
          format.html { redirect_to calendar_url, :notice  => "Successfully updated workorder." }
          format.js
        end


      else
        render :action => 'edit'
      end

  end

  def update
    @workorder= Workorder.find(params[:id])
    @workorder_comparison=Workorder.find(params[:id])
    if @workorder.update_attributes(params[:workorder])
      @workorder_changes=@workorder.differs_from @workorder_comparison,
              :ignore_attributes=>['id', 'created_at', 'updated_at', 'latitude','longitude','gmaps']
      @workorder_changes.each do |key, value|
        @update=current_user.updates.new
        @update.feed_item=current_user.name << " changed " << @workorder.customer.titleize << " from #{value.last} to #{value.first}."
        @update.save
      end
      respond_to do |format|
        format.html { redirect_to root_url, :notice  => "Successfully updated workorder." }
        format.js
      end


    else
      @users = User.where("current_branch=?",current_user.current_branch)
      render :action => 'edit'
    end
  end

end
