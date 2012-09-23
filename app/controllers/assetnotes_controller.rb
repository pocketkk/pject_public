class AssetnotesController < ApplicationController
  def index
    @assetnotes = Assetnote.all
  end

  def new
    @assetnote = Assetnote.new
  end

  def create
    @assetnote = Assetnote.new(params[:assetnote])
    if @assetnote.save
      redirect_to assetnotes_url, :notice => "Successfully created assetnote."
    else
      render :action => 'new'
    end
  end
end
