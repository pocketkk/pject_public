class ChemicalsController < ApplicationController
  def index
    @chemicals = Chemical.all
  end

  def show
    @chemical = Chemical.find(params[:id])
  end

  def new
    @chemical = Chemical.new
  end

  def create
    @chemical = Chemical.new(params[:chemical])
    if @chemical.save
      redirect_to @chemical, :notice => "Successfully created chemical."
    else
      render :action => 'new'
    end
  end

  def edit
    @chemical = Chemical.find(params[:id])
  end

  def update
    @chemical = Chemical.find(params[:id])
    if @chemical.update_attributes(params[:chemical])
      redirect_to @chemical, :notice  => "Successfully updated chemical."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @chemical = Chemical.find(params[:id])
    @chemical.destroy
    redirect_to chemicals_url, :notice => "Successfully destroyed chemical."
  end
end
