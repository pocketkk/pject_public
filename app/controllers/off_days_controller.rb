class OffDaysController < ApplicationController

  def index
    @users=User.where('current_branch=?', current_user.current_branch)
  end

  def show
    @off_day = Off_day.find(params[:id])
  end

  def new
    @off_day = Off_day.new
  end

  def create
    @off_day = current_user.off_day.build(params[:off_day])
    @users=User.where('current_branch=?', current_user.current_branch)
    if @off_day.save
      redirect_to @off_day, :notice => "Successfully created off_day."
    else
      render :action => 'new'
    end
  end

  def edit
    @off_day = Off_day.find(params[:id])
    @users=User.where('current_branch=?', current_user.current_branch)
  end

  def update
    @off_day = Off_day.find(params[:id])
    if @off_day.update_attributes(params[:off_day])
      redirect_to @off_day, :notice  => "Successfully updated off_day."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @off_day = Off_day.find(params[:id])
    @off_day.destroy
    redirect_to off_days_url, :notice => "Successfully destroyed off_day."
  end
end
