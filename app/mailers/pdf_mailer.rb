class PdfMailer < ActionMailer::Base
  default from: "admin@workordermachine.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.pdf_mailer.mail_pdf.subject
  #
  def mail_pdf
    
    #attachments['specsheet.pdf'] = File.read("#{@pdfdoc.pdfdoc_url}")
    mail to: 'pocketkk@gmail.com', subject: "Auto Chlor System - Requested Document"
  end

end
