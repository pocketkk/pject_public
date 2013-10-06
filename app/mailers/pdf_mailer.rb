require 'net/http'
require 'net/https' # You can remove this if you don't need HTTPS
require 'uri'

class PdfMailer < ActionMailer::Base
  include UsersHelper
  default from: "admin@workordermachine.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.pdf_mailer.mail_pdf.subject
  #

  def mail_pdf(document,email,user,message)
    @user=user
    @document=document
    @email=email
    @message=message

    uri = URI.parse document.pdfdoc_url
    sock= Net::HTTP.new(uri.host, uri.port)
    sock.use_ssl=true
    response=sock.start { |http| http.get uri.path }
    attachments['document.pdf'] = response.body
    mail to: email, subject: "Auto Chlor System - " << document.description.upcase
  end

  def welcome_email(user)
    @user=user
    mail to: user.email, content_type: 'text/html', subject: "Welcome to Workorder Machine!"
  end

  def mail_workorder(workorder,user,type)
    @user=user
    @firstname=first_name(user)
    @workorder=workorder
    mail to: user.email, content_type: 'text/html', subject: "WOM - " << type.upcase << " | "   << @workorder.customer
  end

  def mail_task(task, user, type)
    @user=user
    @firstname=first_name(user)
    @task=task
    mail to: user.email, content_type: 'text/html', subject: "WOM Task - " << type.upcase << " Task "
  end

  def mail_alert(user)
    @user=user
    mail to: "admin@workordermachine.com", subject: "W.O.M. - Pssst: " << user.name << " signed in."
  end

  def mail_comment(workorder,user,comment,commenter)
    @user=user
    @workorder=workorder
    @comment=comment
    @commenter=commenter
    mail to: user.email, content_type: 'text/html', subject: "WOM - New Comment on " << workorder.customer.titleize << "'s workorder."
  end
end
