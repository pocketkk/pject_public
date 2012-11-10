class EmailsController < ApplicationController
  def index
    @emails=Email.all
  end

  def new
    @email=Email.new
  end

  def create
  end

  def destroy
     @email = Email.find(params[:id])
      @email.destroy
      redirect_to emails_url, :notice => "Successfully destroyed email."
  end
end
