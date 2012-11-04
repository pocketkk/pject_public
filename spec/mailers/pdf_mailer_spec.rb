require "spec_helper"

describe PdfMailer do
  describe "mail_pdf" do
    let(:mail) { PdfMailer.mail_pdf }

    it "renders the headers" do
      mail.subject.should eq("Mail pdf")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
