class DayOffsController < ApplicationController
  def index
    @day_offs = DayOff.all
  end

  def show
    @day_off = DayOff.find(params[:id])
  end

  def new
    @day_off = DayOff.new
    @users=user_roster
  end

  def create
    @day_off = DayOff.create(params[:day_off])
    if @day_off.save
      redirect_to root_url, :notice => "Successfully created day off."
    else
      render :action => 'new'
    end
  end

  def edit
    @day_off = DayOff.find(params[:id])
    @users=user_roster
    @user=@day_off.user
  end

  def update
    @day_off = DayOff.find(params[:id])
    if @day_off.update_attributes(params[:day_off])
      redirect_to root_url, :notice  => "Successfully updated day off."
    else
      render :action => 'edit'
    end
  end

  def time_off_feed
    @users=User.where("current_branch=?", params[:id])
    respond_to do |format|
        format.ics
      end
  end

  def destroy
    @day_off = DayOff.find(params[:id])
    @day_off.destroy
    redirect_to root_url :notice => "Successfully destroyed day off."
  end
end
