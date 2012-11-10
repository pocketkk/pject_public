require 'net/http'
require 'net/https' # You can remove this if you don't need HTTPS
require 'uri'

class PdfMailer < ActionMailer::Base
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

end
