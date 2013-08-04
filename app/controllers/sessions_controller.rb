class SessionsController < ApplicationController

  include Mobylette::RespondToMobileRequests

  def new
  end

  def create
      user = User.find_by_email(params[:session][:email].downcase.strip)
      if user && user.authenticate(params[:session][:password]) && user.active
         sign_in user
         flash[:success] = 'Welcome Back!'
        # Send me an email when users log in and create a new session
        PdfMailer.mail_alert(user).deliver
        redirect_to root_path
      else
        flash.now[:error] = 'Invalid email/password combination'
        render 'new'
      end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
