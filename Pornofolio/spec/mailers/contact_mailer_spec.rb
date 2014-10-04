require "spec_helper"

describe ContactMailer do
  describe "send_mail_confirm" do
    let(:mail) { ContactMailer.send_mail_confirm }

    it "renders the headers" do
      mail.subject.should eq("Sendmail confirm")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
