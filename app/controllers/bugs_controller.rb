class BugsController < ApplicationController
  def index
    @bugs = Bug.where("complete=?",false).where("request_type=?","Bug")
    @completed_bugs = Bug.where("complete=?",true)
    @feature_bugs = Bug.where("complete=?", false).where("request_type=?",
     "Feature Request")
  end

  def show
    @bug = Bug.find(params[:id])
  end

  def new
    @bug = Bug.new
  end

  def create
    @bug = current_user.bugs.build(params[:bug])
    if @bug.save
      redirect_to root_path,
      :notice => "Bug or feature request added to the list!"
    else
      render :action => 'new'
    end
  end

  def edit
    @bug = Bug.find(params[:id])
  end

  def update
    @bug = Bug.find(params[:id])
    if @bug.update_attributes(params[:bug])
      redirect_to bugs_path, :notice  => "Successfully updated bug."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @bug = Bug.find(params[:id])
    @bug.destroy
    redirect_to bugs_url, :notice => "Successfully destroyed bug."
  end

  def complete
    @bug = Bug.find(params[:id])
    if @bug.update_attributes(:complete => true)
      Updater.new(@bug, update_type: :update,
        user: current_user, message: @bug.update_message(current_user))
      redirect_to bugs_path, :notice => "Bug squashed!"
    else
      redirect_to bugs_path,
      :error => "Oops something went wrong, bug is still alive and kicking."
    end
  end

end
