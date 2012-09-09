class OptionsController < ApplicationController
  def index
    @options = Option.all
  end

  def show
    @option = Option.find(params[:id])
  end

  def new
    @option = Option.new
  end

  def create
    @option = Option.new(params[:option])
    if @option.save
      redirect_to @option, :notice => "Successfully created option."
    else
      render :action => 'new'
    end
  end

  def edit
    @option = Option.find(params[:id])
  end

  def update
    @option = Option.find(params[:id])
    if @option.update_attributes(params[:option])
      redirect_to @option, :notice  => "Successfully updated option."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @option = Option.find(params[:id])
    @option.destroy
    redirect_to options_url, :notice => "Successfully destroyed option."
  end
end
